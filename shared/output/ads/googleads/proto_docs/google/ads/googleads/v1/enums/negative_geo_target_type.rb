# frozen_string_literal: true

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Google
  module Ads
    module GoogleAds
      module V1
        module Enums
          # Container for enum describing possible negative geo target types.
          class NegativeGeoTargetTypeEnum
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods

            # The possible negative geo target types.
            module NegativeGeoTargetType
              # Not specified.
              UNSPECIFIED = 0

              # The value is unknown in this version.
              UNKNOWN = 1

              # Specifies that a user is excluded from seeing the ad if either their
              # Area of Interest (AOI) or their Location of Presence (LOP) matches the
              # geo target.
              DONT_CARE = 2

              # Specifies that a user is excluded from seeing the ad
              # only if their Location of Presence (LOP) matches the geo target.
              LOCATION_OF_PRESENCE = 3
            end
          end
        end
      end
    end
  end
end
