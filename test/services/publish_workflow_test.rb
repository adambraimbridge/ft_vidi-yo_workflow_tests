require 'test/unit'
require_relative '../../lib/webservice_clients/workflows/publish_workflow'
require 'vcr'
require_relative '../../vcr_setup'

class PublishWorkflowTest < Test::Unit::TestCase


  def setup
    @project_uuid = SecureRandom.uuid
    VCR.use_cassette 'create publish workflow' do
      @publish_workflow = PublishWorkflow.new.create @project_uuid
    end
  end

  def test_can_create_workflow
    assert_kind_of(PublishWorkflow, @publish_workflow)
  end

  def test_status_is_a_string
    assert_kind_of(String, @publish_workflow.status)
  end

  def test_workflow_has_a_workflow_log
    assert_kind_of(Hash, @publish_workflow.workflow_log)
  end

  def test_workflow_has_an_id
    assert_kind_of(Fixnum, @publish_workflow.id)
  end

end