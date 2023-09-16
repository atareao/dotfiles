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
import logging

logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG)

BASE_URL = "https://api.open-meteo.com"


class OpenMeteoClient:
    def __init__(self, latitude: float, longitude: float) -> None:
        self._latitude = latitude
        self._longitude = longitude

    @staticmethod
    def get_icon(code: int) -> str:
        """
        WMO Weather interpretation codes (WW)
        Code        Description
        0           Clear sky
        1, 2, 3     Mainly clear, partly cloudy, and overcast
        45, 48      Fog and depositing rime fog
        51, 53, 55  Drizzle: Light, moderate, and dense intensity
        56, 57      Freezing Drizzle: Light and dense intensity
        61, 63, 65  Rain: Slight, moderate and heavy intensity
        66, 67      Freezing Rain: Light and heavy intensity
        71, 73, 75  Snow fall: Slight, moderate, and heavy intensity
        77          Snow grains
        80, 81, 82  Rain showers: Slight, moderate, and violent
        85, 86      Snow showers slight and heavy
        95 *        Thunderstorm: Slight or moderate
        96, 99 *    Thunderstorm with slight and heavy hail
        (*) Thunderstorm forecast with hail is only available in Central Europe
        """
        if code == 0:
            # Clear sky
            return "☀️"
        elif code in [1, 2, 3]:
            # Mainly clear, partly cloudy, and overcast
            return "⛅"
        elif code in [45, 58]:
            # Fog and depositing rime fog
            return "🌁"
        elif code in [51, 53, 55]:
            # Drizzle: Light, moderate, and dense intensity
            return "🌦️"
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
            return "🌧️"
        elif code in [85, 86]:
            # Snow showers slight and heavy
            pass
        elif code == 95:
            # Thunderstorm: Slight or moderate
            pass
        elif code in [96, 99]:
            # Thunderstorm with slight and heavy hail
            return "⛈️"
        return "🤷"

    def current_weather(self):
        url = f"{BASE_URL}/v1/forecast"
        logging.debug(f"Url: {url}")
        params = {
                "latitude": self._latitude,
                "longitude": self._longitude,
                "current_weather": True
                }
        logging.debug(f"Params: {params}")
        response = requests.get(url, params=params)
        logging.debug(f"Status code: {response.status_code}")
        logging.debug(f"Response: {response.text}")
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
        logging.debug(sys.argv)
        latitude = float(sys.argv[1])
        longitude = float(sys.argv[2])
        client = OpenMeteoClient(latitude, longitude)
        print(client.current_weather())
    else:
        latitude = 39.36667
        longitude = -0.41667
        client = OpenMeteoClient(latitude, longitude)
        print(client.current_weather())

