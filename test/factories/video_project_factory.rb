# frozen_string_literal: true
require_relative '../../test/data/video_project'

FactoryGirl.define do
  factory :mio_video_project, class: VideoProject do |asset|
    asset.project_name 'AT Test Project'
    asset.section 'Markets and Investment'
    asset.brand 'FT World'
  end
end
