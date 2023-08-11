#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Copyright (c) 2023 Lorenzo Carbonell <a.k.a. atareao>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import requests
import sys

BASE_URL = "https://api.open-meteo.com"


class OpenMeteoClient:
    def __init__(self, latitude: float, longitude: float) -> None:
        self._latitude = latitude
        self._longitude = longitude

    @staticmethod
    def get_icon(code: int) -> str:
        if code == 0:
            # Clear sky
            return "☀️"
        elif code in [1, 2, 3]:
            # Mainly clear, partly cloudy, and overcast
            return "⛅"
        elif code in [45, 58]:
            # Fog and depositing rime fog
            pass
        elif code in [51, 53, 55]:
            # Drizzle: Light, moderate, and dense intensity
            pass
        elif code in [56, 57]:
            # Freezing Drizzle: Light and dense intensity
            pass
        elif code in [61, 63, 65]:
            # Rain: Slight, moderate and heavy intensity
            return "🌧️"
        elif code in [66, 67]:
            # Freezing Rain: Light and heavy intensity
            pass
        elif code in [71, 73, 75]:
            # Snow fall: Slight, moderate, and heavy intensity
            pass
        elif code == 77:
            # 77 Snow grains
            pass
        elif code in [80, 81, 82]:
            # Rain showers: Slight, moderate, and violent
            pass
        elif code in [85, 86]:
            # Snow showers slight and heavy
            pass
        elif code == 95:
            # Thunderstorm: Slight or moderate
            pass
        elif code in [96, 99]:
            # Thunderstorm with slight and heavy hail
            pass
        return "🤷"

    def current_weather(self):
        url = f"{BASE_URL}/v1/forecast"
        params = {
                "latitude": self._latitude,
                "longitude": self._longitude,
                "current_weather": True
                }
        response = requests.get(url, params=params)
        if response.status_code == 200:
            data = response.json()
            current_weather = data["current_weather"]
            icon = self.get_icon(current_weather["weathercode"])
            temperature = current_weather["temperature"]
        else:
            icon = "🤷"
            temperature = "-"
        return f"{icon} {temperature}"


if __name__ == "__main__":
    if len(sys.argv) > 2:
        latitude = float(sys.argv[1])
        longitude = float(sys.argv[2])
        client = OpenMeteoClient(latitude, longitude)
        print(client.current_weather())
