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

require "test_helper"

class GarbageServiceTest < PresenterTest
  def presenter
    service_presenter :garbage, "GarbageService"
  end

  def test_name
    assert_equal "GarbageService", presenter.name
  end

  def test_methods
    refute_empty presenter.methods
    presenter.methods.each { |ref| assert_kind_of MethodPresenter, ref }
    exp_method_names = ["get_simple_garbage", "get_specific_garbage", "get_nested_garbage", "get_repeated_garbage", "long_running_garbage", "client_garbage", "server_garbage", "bidi_garbage"]
    assert_equal exp_method_names, presenter.methods.map(&:name)
  end

  def test_references
    refute_empty presenter.references
    presenter.references.each { |ref| assert_kind_of ResourcePresenter, ref }
    assert_equal ["SimpleGarbage"], presenter.references.map(&:name)
    assert_equal ["projects/{project}/simple_garbage/{garbage}"], presenter.references.map(&:path_template)
  end

  def test_proto_service_name_full
    assert_equal "So::Much::Trash::GarbageService", presenter.proto_service_name_full
  end

  def test_proto_service_file_path
    assert_equal "garbage/garbage_pb.rb", presenter.proto_service_file_path
  end

  def test_proto_service_file_name
    assert_equal "garbage_pb.rb", presenter.proto_service_file_name
  end

  def test_proto_service_require
    assert_equal "garbage/garbage_pb", presenter.proto_service_require
  end

  def test_proto_services_file_path
    assert_equal "garbage/garbage_services_pb.rb", presenter.proto_services_file_path
  end

  def test_proto_services_file_name
    assert_equal "garbage_services_pb.rb", presenter.proto_services_file_name
  end

  def test_proto_services_require
    assert_equal "garbage/garbage_services_pb", presenter.proto_services_require
  end

  def test_proto_service_stub_name_full
    assert_equal "So::Much::Trash::GarbageService::Stub", presenter.proto_service_stub_name_full
  end

  def test_credentials_name
    assert_equal "Credentials", presenter.credentials_name
  end

  def test_credentials_name_full
    assert_equal "So::Much::Trash::GarbageService::Credentials", presenter.credentials_name_full
  end

  def test_credentials_file_path
    assert_equal "so/much/trash/garbage_service/credentials.rb", presenter.credentials_file_path
  end

  def test_credentials_file_name
    assert_equal "credentials.rb", presenter.credentials_file_name
  end

  def test_credentials_require
    assert_equal "so/much/trash/garbage_service/credentials", presenter.credentials_require
  end

  def test_operations_name
    assert_equal "Operations", presenter.operations_name
  end

  def test_operations_name_full
    assert_equal "So::Much::Trash::GarbageService::Operations", presenter.operations_name_full
  end

  def test_operations_file_path
    assert_equal "so/much/trash/garbage_service/operations.rb", presenter.operations_file_path
  end

  def test_operations_file_name
    assert_equal "operations.rb", presenter.operations_file_name
  end

  def test_operations_require
    assert_equal "so/much/trash/garbage_service/operations", presenter.operations_require
  end

  def test_helpers_file_path
    assert_equal "so/much/trash/garbage_service/helpers.rb", presenter.helpers_file_path
  end

  def test_helpers_file_name
    assert_equal "helpers.rb", presenter.helpers_file_name
  end

  def test_helpers_require
    assert_equal "so/much/trash/garbage_service/helpers", presenter.helpers_require
  end

  def test_test_client_file_path
    assert_equal "so/much/trash/garbage_service_test.rb", presenter.test_client_file_path
  end

  def test_stub_name
    assert_equal "garbage_service_stub", presenter.stub_name
  end

  def test_lro?
    assert presenter.lro?
  end

  def test_lro_service
    assert_kind_of ServicePresenter, presenter.lro_service
  end

  def test_lro_client_var
    assert_equal "operations_client", presenter.lro_client_var
  end

  def test_lro_client_ivar
    assert_equal "@operations_client", presenter.lro_client_ivar
  end
  def test_paths?
    assert presenter.paths?
  end

  def test_paths_name
    assert_equal "Paths", presenter.paths_name
  end

  def test_paths_name_full
    assert_equal "So::Much::Trash::GarbageService::Paths", presenter.paths_name_full
  end

  def test_paths_file_path
    assert_equal "so/much/trash/garbage_service/paths.rb", presenter.paths_file_path
  end

  def test_paths_file_name
    assert_equal "paths.rb", presenter.paths_file_name
  end

  def test_paths_require
    assert_equal "so/much/trash/garbage_service/paths", presenter.paths_require
  end
end
