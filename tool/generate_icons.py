#!/usr/bin/env python3
"""Generate iOS app icon PNGs from assets/app_icon.png."""

from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
SOURCE = ROOT / "assets/app_icon.png"
OUT = ROOT / "ios/Runner/Assets.xcassets/AppIcon.appiconset"

SIZES = {
    "Icon-App-20x20@1x.png": 20,
    "Icon-App-20x20@2x.png": 40,
    "Icon-App-20x20@3x.png": 60,
    "Icon-App-29x29@1x.png": 29,
    "Icon-App-29x29@2x.png": 58,
    "Icon-App-29x29@3x.png": 87,
    "Icon-App-40x40@1x.png": 40,
    "Icon-App-40x40@2x.png": 80,
    "Icon-App-40x40@3x.png": 120,
    "Icon-App-60x60@2x.png": 120,
    "Icon-App-60x60@3x.png": 180,
    "Icon-App-76x76@1x.png": 76,
    "Icon-App-76x76@2x.png": 152,
    "Icon-App-83.5x83.5@2x.png": 167,
    "Icon-App-1024x1024@1x.png": 1024,
}


def main():
    if not SOURCE.exists():
        raise SystemExit(f"Missing source icon: {SOURCE}")
    img = Image.open(SOURCE).convert("RGBA")
    OUT.mkdir(parents=True, exist_ok=True)
    for name, px in SIZES.items():
        img.resize((px, px), Image.Resampling.LANCZOS).save(OUT / name, "PNG")
        print(f"Wrote {name} ({px}px)")


if __name__ == "__main__":
    main()
