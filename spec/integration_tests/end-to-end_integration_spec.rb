# frozen_string_literal: true
require_relative '../spec_helper'
require_relative '../../config/config'
require_relative '../../lib/webservice_clients/workflows/end_to_end_workflow'
require 'rspec/wait'

RSpec.describe EndToEndWorkflow do
  include Config::Logging

  context 'live integration testing' do

    before :each do
      @project_uuid = SecureRandom.uuid
      info_logger :info, 'CREATED UUID: ' + @project_uuid
      @project_workflow_client = ProjectWorkflow.new
      @project = @project_workflow_client.create @project_uuid
      expect(@project.uuid.contains_uuid?).to be_truthy
      wait_for_complete @project
    end

    it 'can complete a project workflow' do
      true
    end

    it 'can complete an ingestion workflow' do
      ingestion_workflow_client = IngestWorkflow.new
      ingestion_workflow = ingestion_workflow_client.create @project_uuid
      wait_for_complete ingestion_workflow
    end

    it 'can complete a publish workflow' do
      publish_workflow_client = PublishWorkflow.new
      publish_workflow = publish_workflow_client.create @project_uuid
      wait_for_complete publish_workflow
    end

  end


end