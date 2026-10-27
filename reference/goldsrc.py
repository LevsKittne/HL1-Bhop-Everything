"""Portable planar HL1 formula reference, in GoldSource units; no game interaction.

Inputs use two horizontal axes. Jump limiting is planar; the original HL1 check
uses 3D speed before the jump impulse, matching this helper when vertical speed
is zero. Caller supplies valid jump eligibility and any edge-friction trace.
"""
from dataclasses import dataclass
import argparse
import json
import math
import random


@dataclass(frozen=True)
class Settings:
    accelerate: float = 10.0
    airaccelerate: float = 10.0
    friction: float = 4.0
    stopspeed: float = 100.0
    air_wish_cap: float = 30.0
    stock_bunny_limit: bool = True


def step(velocity, wish, dt, maxspeed=300.0, *, grounded=False, jump=False,
         surface_friction=1.0, edge_multiplier=1.0, settings=Settings()):
    """One planar step; jump=True means an actually permitted ground jump.

    Surface friction is the character multiplier, not sv_friction. Normal ground
    uses edge_multiplier=1; use 2 only when the caller's ledge trace selects it.
    A zero duration performs no step. Vertical physics and collision stay outside.
    """
    values = (*velocity, *wish, dt, maxspeed, surface_friction, edge_multiplier)
    if not all(math.isfinite(value) for value in values):
        raise ValueError('Inputs must be finite')
    if min(dt, maxspeed, surface_friction, edge_multiplier) < 0:
        raise ValueError('Duration, speed and friction must be nonnegative')
    x, y = map(float, velocity)
    if dt == 0:
        return x, y
    wish_length = math.hypot(*wish)
    wishspeed = min(wish_length, maxspeed)
    airborne = not grounded or jump
    if grounded and jump and settings.stock_bunny_limit:
        speed = math.hypot(x, y)
        limit = 1.7 * maxspeed
        if limit > 0 and speed > limit:
            fraction = limit / speed * 0.65
            x *= fraction
            y *= fraction
    if not airborne:
        speed = math.hypot(x, y)
        if speed >= 0.1:
            drop = (max(speed, settings.stopspeed) * settings.friction * dt
                    * surface_friction * edge_multiplier)
            fraction = max(speed - drop, 0.0) / speed
            x *= fraction
            y *= fraction
    if wish_length > 0:
        dx, dy = wish[0] / wish_length, wish[1] / wish_length
        projection_limit = min(wishspeed, settings.air_wish_cap) if airborne else wishspeed
        remaining = projection_limit - (x * dx + y * dy)
        if remaining > 0:
            accelerate = settings.airaccelerate if airborne else settings.accelerate
            # Air deliberately uses the full wishspeed, not projection_limit.
            impulse = min(remaining, accelerate * wishspeed * dt * surface_friction)
            x += dx * impulse
            y += dy * impulse
    if not airborne and math.hypot(x, y) < 1.0:
        return 0.0, 0.0
    return x, y


def self_test():
    def close(actual, wanted):
        assert all(math.isclose(a, b, abs_tol=1e-8) for a, b in zip(actual, wanted)), (actual, wanted)
    close(step((0, 0), (300, 0), .001), (3, 0))
    close(step((0, 0), (300, 0), .016), (30, 0))
    close(step((0, 0), (600, 0), .001), (3, 0))
    close(step((0, 0), (6, 0), .016), (.96, 0))
    close(step((600, 0), (0, 0), .016), (600, 0))
    close(step((600, 0), (0, 0), .016, grounded=True, jump=True), (331.5, 0))
    close(step((600, 0), (0, 0), .016, grounded=True, jump=True,
               settings=Settings(stock_bunny_limit=False)), (600, 0))
    close(step((60, 0), (0, 0), .016, grounded=True), (53.6, 0))
    close(step((60, 0), (0, 0), .016, grounded=True, edge_multiplier=2), (47.2, 0))
    close(step((.5, 0), (0, 0), .001, grounded=True), (0, 0))
    close(step((10, 20), (300, 0), 0, grounded=True), (10, 20))
    close(step((300, 0), (300, 0), .016), (300, 0))
    rng = random.Random(27102026)
    for _ in range(10000):
        velocity = tuple(rng.uniform(-1000, 1000) for _ in range(2))
        angle = rng.uniform(-math.pi, math.pi)
        magnitude = rng.uniform(.001, 600)
        wish = magnitude * math.cos(angle), magnitude * math.sin(angle)
        dt = rng.uniform(.0001, .1)
        maximum = rng.uniform(100, 500)
        friction = rng.uniform(0, 1)
        direction = math.cos(angle), math.sin(angle)
        before = sum(v * d for v, d in zip(velocity, direction))
        impulse = max(0, min(min(magnitude, maximum, 30) - before,
                             10 * min(magnitude, maximum) * dt * friction))
        result = step(velocity, wish, dt, maximum, surface_friction=friction)
        after = sum(v * d for v, d in zip(result, direction))
        assert math.isclose(after - before, impulse, abs_tol=1e-8)
        # Acceleration may change only the commanded direction.
        cross = ((result[0] - velocity[0]) * direction[1]
                 - (result[1] - velocity[1]) * direction[0])
        assert abs(cross) < 1e-8
    print('PASS: fixed HL1 regression cases and 10000 randomized air projection checks')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--self-test', action='store_true')
    parser.add_argument('--velocity', nargs=2, type=float, default=(300, 0))
    parser.add_argument('--wish', nargs=2, type=float, default=(0, 300))
    parser.add_argument('--dt', type=float, default=.016)
    parser.add_argument('--maxspeed', type=float, default=300)
    parser.add_argument('--grounded', action='store_true')
    parser.add_argument('--jump', action='store_true')
    parser.add_argument('--uncapped-bhop', action='store_true')
    args = parser.parse_args()
    if args.self_test:
        self_test()
        return
    result = step(args.velocity, args.wish, args.dt, args.maxspeed,
                  grounded=args.grounded, jump=args.jump,
                  settings=Settings(stock_bunny_limit=not args.uncapped_bhop))
    print(json.dumps({'velocity': result, 'speed_ups': math.hypot(*result)}))


if __name__ == '__main__':
    main()
