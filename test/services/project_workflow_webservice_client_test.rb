# frozen_string_literal: true
require 'test/unit'
require_relative '../test_helper'
require_relative '../video_test'
require_relative '../../lib/webservice_clients/workflow_clients/project_workflow_webservice_client'

class ProjectWorkflowWebserviceClientTest < VideoTest

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @project_workflow_ws_client = ProjectWorkflowWebserviceClient.new
  end

  def test_create_valid_project
    VCR.use_cassette 'unit test project client' do
      @workflow = @project_workflow_ws_client.create_project_workflow
    end
    assert_respond_to(@workflow, :has_key?)
    assert(@workflow.has_key?('id'))
  end

  def test_create_default_payload
    payload = @project_workflow_ws_client.create_project_workflow_payload
    assert_respond_to(payload, :has_key?)
    assert(payload.has_key?(:definitionId))
  end

  def test_create_custom_payload
    payload = @project_workflow_ws_client.create_project_workflow_payload('TEST', 'TEST', 'TEST')
    payload_string_variables = payload[:stringVariables][:projectMetadata]
    assert_respond_to(payload_string_variables, :=~)
    info_logger :info, "Payload String Variables: #{payload_string_variables}"
    assert_match(/"TEST"/, payload_string_variables)
  end

end
