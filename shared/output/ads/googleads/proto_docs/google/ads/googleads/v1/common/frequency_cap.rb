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
        module Common
          # A rule specifying the maximum number of times an ad (or some set of ads) can
          # be shown to a user over a particular time period.
          # @!attribute [rw] key
          #   @return [Google::Ads::GoogleAds::V1::Common::FrequencyCapKey]
          #     The key of a particular frequency cap. There can be no more
          #     than one frequency cap with the same key.
          # @!attribute [rw] cap
          #   @return [Google::Protobuf::Int32Value]
          #     Maximum number of events allowed during the time range by this cap.
          class FrequencyCapEntry
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end

          # A group of fields used as keys for a frequency cap.
          # There can be no more than one frequency cap with the same key.
          # @!attribute [rw] level
          #   @return [ENUM(FrequencyCapLevel)]
          #     The level on which the cap is to be applied (e.g. ad group ad, ad group).
          #     The cap is applied to all the entities of this level.
          # @!attribute [rw] event_type
          #   @return [ENUM(FrequencyCapEventType)]
          #     The type of event that the cap applies to (e.g. impression).
          # @!attribute [rw] time_unit
          #   @return [ENUM(FrequencyCapTimeUnit)]
          #     Unit of time the cap is defined at (e.g. day, week).
          # @!attribute [rw] time_length
          #   @return [Google::Protobuf::Int32Value]
          #     Number of time units the cap lasts.
          class FrequencyCapKey
            include Google::Protobuf::MessageExts
            extend Google::Protobuf::MessageExts::ClassMethods
          end
        end
      end
    end
  end
end
