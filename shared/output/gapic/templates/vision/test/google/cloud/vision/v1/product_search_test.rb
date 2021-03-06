# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright <YEAR> <COPYRIGHT HOLDER>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "minitest/autorun"

require "google/cloud/vision/v1/product_search_service_pb"
require "google/cloud/vision/v1/product_search_service_services_pb"
require "google/cloud/vision/v1/product_search"

class CustomTestErrorV1 < StandardError; end
# Mock for the GRPC::ClientStub class.
class MockGrpcClientStubV1
  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize expected_symbol, mock_method
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren"t being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method symbol
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

class MockProductSearchCredentialsV1 < Google::Cloud::Vision::V1::ProductSearch::Credentials
  def initialize method_name
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
          "happen since the grpc layer is being mocked."
    end
  end
end

describe Google::Cloud::Vision::V1::ProductSearch::Client do
  describe "create_product_set" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#create_product_set."
    end

    it "invokes create_product_set without error" do
      # Create request parameters
      parent = "hello world"
      product_set = {}
      product_set_id = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ProductSet

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::CreateProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(product_set, to: Google::Cloud::Vision::V1::ProductSet), request.product_set
        assert_equal Google::Gax::Protobuf.coerce(product_set_id, to: ), request.product_set_id
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :create_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.create_product_set parent, product_set, product_set_id

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_product_set parent, product_set, product_set_id do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes create_product_set with error" do
      # Create request parameters
      parent = "hello world"
      product_set = {}
      product_set_id = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::CreateProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(product_set, to: Google::Cloud::Vision::V1::ProductSet), request.product_set
        assert_equal Google::Gax::Protobuf.coerce(product_set_id, to: ), request.product_set_id
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :create_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_product_set parent, product_set, product_set_id
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_product_sets" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#list_product_sets."
    end

    it "invokes list_product_sets without error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ListProductSetsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListProductSetsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_product_sets, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_product_sets"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.list_product_sets parent, page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_product_sets parent, page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_product_sets with error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListProductSetsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_product_sets, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_product_sets"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_product_sets parent, page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_product_set" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#get_product_set."
    end

    it "invokes get_product_set without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ProductSet

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::GetProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.get_product_set name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_product_set name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_product_set with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::GetProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_product_set name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "update_product_set" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#update_product_set."
    end

    it "invokes update_product_set without error" do
      # Create request parameters
      product_set = {}
      update_mask = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ProductSet

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::UpdateProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(product_set, to: Google::Cloud::Vision::V1::ProductSet), request.product_set
        assert_equal Google::Gax::Protobuf.coerce(update_mask, to: Google::Protobuf::FieldMask), request.update_mask
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :update_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.update_product_set product_set, update_mask

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.update_product_set product_set, update_mask do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes update_product_set with error" do
      # Create request parameters
      product_set = {}
      update_mask = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::UpdateProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(product_set, to: Google::Cloud::Vision::V1::ProductSet), request.product_set
        assert_equal Google::Gax::Protobuf.coerce(update_mask, to: Google::Protobuf::FieldMask), request.update_mask
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :update_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_product_set product_set, update_mask
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_product_set" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#delete_product_set."
    end

    it "invokes delete_product_set without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::DeleteProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.delete_product_set name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_product_set name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_product_set with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::DeleteProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_product_set name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "create_product" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#create_product."
    end

    it "invokes create_product without error" do
      # Create request parameters
      parent = "hello world"
      product = {}
      product_id = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::Product

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::CreateProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(product, to: Google::Cloud::Vision::V1::Product), request.product
        assert_equal Google::Gax::Protobuf.coerce(product_id, to: ), request.product_id
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :create_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.create_product parent, product, product_id

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_product parent, product, product_id do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes create_product with error" do
      # Create request parameters
      parent = "hello world"
      product = {}
      product_id = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::CreateProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(product, to: Google::Cloud::Vision::V1::Product), request.product
        assert_equal Google::Gax::Protobuf.coerce(product_id, to: ), request.product_id
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :create_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_product parent, product, product_id
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_products" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#list_products."
    end

    it "invokes list_products without error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ListProductsResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListProductsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_products, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_products"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.list_products parent, page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_products parent, page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_products with error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListProductsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_products, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_products"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_products parent, page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_product" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#get_product."
    end

    it "invokes get_product without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::Product

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::GetProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.get_product name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_product name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_product with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::GetProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_product name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "update_product" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#update_product."
    end

    it "invokes update_product without error" do
      # Create request parameters
      product = {}
      update_mask = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::Product

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::UpdateProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(product, to: Google::Cloud::Vision::V1::Product), request.product
        assert_equal Google::Gax::Protobuf.coerce(update_mask, to: Google::Protobuf::FieldMask), request.update_mask
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :update_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.update_product product, update_mask

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.update_product product, update_mask do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes update_product with error" do
      # Create request parameters
      product = {}
      update_mask = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::UpdateProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(product, to: Google::Cloud::Vision::V1::Product), request.product
        assert_equal Google::Gax::Protobuf.coerce(update_mask, to: Google::Protobuf::FieldMask), request.update_mask
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :update_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "update_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.update_product product, update_mask
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_product" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#delete_product."
    end

    it "invokes delete_product without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::DeleteProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.delete_product name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_product name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_product with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::DeleteProductRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_product, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_product"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_product name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "create_reference_image" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#create_reference_image."
    end

    it "invokes create_reference_image without error" do
      # Create request parameters
      parent = "hello world"
      reference_image = {}
      reference_image_id = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ReferenceImage

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::CreateReferenceImageRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(reference_image, to: Google::Cloud::Vision::V1::ReferenceImage), request.reference_image
        assert_equal Google::Gax::Protobuf.coerce(reference_image_id, to: ), request.reference_image_id
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :create_reference_image, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_reference_image"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.create_reference_image parent, reference_image, reference_image_id

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.create_reference_image parent, reference_image, reference_image_id do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes create_reference_image with error" do
      # Create request parameters
      parent = "hello world"
      reference_image = {}
      reference_image_id = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::CreateReferenceImageRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(reference_image, to: Google::Cloud::Vision::V1::ReferenceImage), request.reference_image
        assert_equal Google::Gax::Protobuf.coerce(reference_image_id, to: ), request.reference_image_id
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :create_reference_image, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "create_reference_image"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.create_reference_image parent, reference_image, reference_image_id
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "delete_reference_image" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#delete_reference_image."
    end

    it "invokes delete_reference_image without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::DeleteReferenceImageRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :delete_reference_image, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_reference_image"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.delete_reference_image name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.delete_reference_image name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes delete_reference_image with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::DeleteReferenceImageRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :delete_reference_image, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "delete_reference_image"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.delete_reference_image name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_reference_images" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#list_reference_images."
    end

    it "invokes list_reference_images without error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ListReferenceImagesResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListReferenceImagesRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_reference_images, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_reference_images"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.list_reference_images parent, page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_reference_images parent, page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_reference_images with error" do
      # Create request parameters
      parent = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListReferenceImagesRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_reference_images, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_reference_images"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_reference_images parent, page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "get_reference_image" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#get_reference_image."
    end

    it "invokes get_reference_image without error" do
      # Create request parameters
      name = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ReferenceImage

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::GetReferenceImageRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :get_reference_image, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_reference_image"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.get_reference_image name

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.get_reference_image name do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes get_reference_image with error" do
      # Create request parameters
      name = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::GetReferenceImageRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :get_reference_image, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "get_reference_image"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.get_reference_image name
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "add_product_to_product_set" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#add_product_to_product_set."
    end

    it "invokes add_product_to_product_set without error" do
      # Create request parameters
      name = "hello world"
      product = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::AddProductToProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(product, to: ), request.product
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :add_product_to_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "add_product_to_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.add_product_to_product_set name, product

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.add_product_to_product_set name, product do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes add_product_to_product_set with error" do
      # Create request parameters
      name = "hello world"
      product = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::AddProductToProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(product, to: ), request.product
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :add_product_to_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "add_product_to_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.add_product_to_product_set name, product
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "remove_product_from_product_set" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#remove_product_from_product_set."
    end

    it "invokes remove_product_from_product_set without error" do
      # Create request parameters
      name = "hello world"
      product = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Protobuf::Empty

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(product, to: ), request.product
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :remove_product_from_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "remove_product_from_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.remove_product_from_product_set name, product

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.remove_product_from_product_set name, product do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes remove_product_from_product_set with error" do
      # Create request parameters
      name = "hello world"
      product = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::RemoveProductFromProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(product, to: ), request.product
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :remove_product_from_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "remove_product_from_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.remove_product_from_product_set name, product
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "list_products_in_product_set" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#list_products_in_product_set."
    end

    it "invokes list_products_in_product_set without error" do
      # Create request parameters
      name = "hello world"
      page_size = 42
      page_token = "hello world"

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Cloud::Vision::V1::ListProductsInProductSetResponse

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListProductsInProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        OpenStruct.new execute: expected_response
      end
      mock_stub = MockGrpcClientStubV1.new :list_products_in_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_products_in_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.list_products_in_product_set name, page_size, page_token

          # Verify the response
          assert_equal expected_response, response

          # Call method with block
          client.list_products_in_product_set name, page_size, page_token do |resp, operation|
            # Verify the response
            assert_equal expected_response, resp
            refute_nil operation
          end
        end
      end
    end

    it "invokes list_products_in_product_set with error" do
      # Create request parameters
      name = "hello world"
      page_size = 42
      page_token = "hello world"

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ListProductsInProductSetRequest, request
        assert_equal Google::Gax::Protobuf.coerce(name, to: ), request.name
        assert_equal Google::Gax::Protobuf.coerce(page_size, to: ), request.page_size
        assert_equal Google::Gax::Protobuf.coerce(page_token, to: ), request.page_token
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :list_products_in_product_set, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "list_products_in_product_set"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.list_products_in_product_set name, page_size, page_token
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end

  describe "import_product_sets" do
    let :custom_error do
      CustomTestErrorV1.new "Custom test error for Google::Cloud::Vision::V1::ProductSearch::Client#import_product_sets."
    end

    it "invokes import_product_sets without error" do
      # Create request parameters
      parent = "hello world"
      input_config = {}

      # Create expected grpc response
      expected_response = {}
      expected_response = Google::Gax::Protobuf.coerce expected_response, to: Google::Longrunning::Operation
      result = Google::Protobuf::Any.new
      result.pack expected_response
      operation = Google::Longrunning::Operation.new(
        name: "operations/import_product_sets_test",
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ImportProductSetsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(input_config, to: Google::Cloud::Vision::V1::ImportProductSetsInputConfig), request.input_config
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :import_product_sets, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "import_product_sets"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.import_product_sets parent, input_config

          # Verify the response
          assert_equal expected_response, response.response
        end
      end
    end

    it "invokes import_product_sets and returns an operation error." do
      # Create request parameters
      parent = "hello world"
      input_config = {}

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: "Operation error for Google::Cloud::Vision::V1::ProductSearch::Client#import_product_sets."
      )
      operation = Google::Longrunning::Operation.new(
        name: "operations/import_product_sets_test",
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ImportProductSetsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(input_config, to: Google::Cloud::Vision::V1::ImportProductSetsInputConfig), request.input_config
        OpenStruct.new execute: operation
      end
      mock_stub = MockGrpcClientStubV1.new :import_product_sets, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "import_product_sets"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          response = client.import_product_sets parent, input_config

          # Verify the response
          assert response.error?
          assert_equal operation_error, response.error
        end
      end
    end

    it "invokes import_product_sets with error" do
      # Create request parameters
      parent = "hello world"
      input_config = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of Google::Cloud::Vision::V1::ImportProductSetsRequest, request
        assert_equal Google::Gax::Protobuf.coerce(parent, to: ), request.parent
        assert_equal Google::Gax::Protobuf.coerce(input_config, to: Google::Cloud::Vision::V1::ImportProductSetsInputConfig), request.input_config
        raise custom_error
      end
      mock_stub = MockGrpcClientStubV1.new :import_product_sets, mock_method

      # Mock auth layer
      mock_credentials = MockSpeechCredentialsV1.new "import_product_sets"

      Google::Cloud::Vision::V1::ProductSearch::Stub.stub :new, mock_stub do
        Google::Cloud::Vision::V1::ProductSearch::Credentials.stub :default, mock_credentials do
          client = Google::Cloud::Vision::V1::ProductSearch::Client.new

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.import_product_sets parent, input_config
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match custom_error.message, err.message
        end
      end
    end
  end
end
