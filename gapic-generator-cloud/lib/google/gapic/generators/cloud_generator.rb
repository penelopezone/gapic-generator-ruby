# frozen_string_literal: true

# Copyright 2018 Google LLC
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

require "google/gapic/generators/default_generator"

module Google
  module Gapic
    module Generators
      # The generator orchestrates the rendering of templates for Google Cloud
      # projects.
      class CloudGenerator < DefaultGenerator
        # Initializes the generator.
        #
        # @param api [Google::Gapic::Schema::Api] The API model/context to
        #   generate.
        def initialize api
          super

          # Configure to use prefer Google Cloud templates
          use_templates! File.join __dir__, "../../../../templates/cloud"
        end

        # Generates all the files for the API.
        #
        # @return [Array<
        #   Google::Protobuf::Compiler::CodeGeneratorResponse::File>]
        #   The files that were generated for the API.
        def generate
          super
        end

        private

        ##
        # Override the default rubocop config file to be used.
        def format_config
          @api.configuration[:format_config] ||
            google_style_config
        end

        ##
        # Path to the rubocop file for this project, which uses google-style
        def google_style_config
          File.expand_path File.join __dir__, "../../../../cloud-rubocop.yml"
        end
      end
    end
  end
end
