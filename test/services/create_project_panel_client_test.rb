require 'test/unit'
require_relative '../../test/data/ws_user'
require_relative '../test_helper'
require_relative '../../lib/web_service_clients/create_project_panel_webservice_client'

class CreateProjectPanelClientTest < MioTest


  def setup
    @mio_fetch_panels_client = CreateProjectPanelWebserviceClient.new(WSUser.new)
    @mio_metadata_service = MioMetadataDescriptionWebserviceClient.new(WSUser.new)
  end

  def test_build_url_for_data_definition
    @panel_name = 'project-metadata'
    id = @mio_metadata_service.retrieve_id_with_name(@panel_name)
    url = @mio_fetch_panels_client.build_url_for_data_definition
    assert_match(/api\/metadataDefinitions\/#{id}\/definition/, url)
  end

  def test_extract_create_project_panel_elements
    @create_project_panel_elements = @mio_fetch_panels_client.extract_panel_elements
    assert_kind_of(Hash, @create_project_panel_elements)
    assert(@create_project_panel_elements.has_key?('project') || @create_project_panel_elements.has_key?('text'),
    'Does not have expected element (project => text)')
  end

  def test_retrieve_create_project_panel_definitions
    create_project_panel_definitions = @mio_fetch_panels_client.retrieve_panel_definitions
    assert_kind_of(Array, create_project_panel_definitions)
  end

  def test_falls_back_to_cache_if_no_service
    mio_cached_client = CreateProjectPanelWebserviceClient.new(WSUser.new,
                                                               'https://master.dev.nativ-systems.com/api/metadataDefinitions/11312/definiti')
    create_project_panel_elements_cached = mio_cached_client.extract_panel_elements
    assert(create_project_panel_elements_cached.has_key?('project') ||
      create_project_panel_elements_cached.has_key?('text'),
           'Does not have expected element (project => text)')
  end

end