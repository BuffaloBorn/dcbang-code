#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'spec_helper.rb'

describe "Release task" do

  let(:jasmine_dev) { JasmineDev.new }

  describe "when the pages submodule is not present" do
    before do
      jasmine_dev.should_receive(:has_pages_submodule?).and_return(false)

      @output = capture_output { jasmine_dev.release_prep }
    end

    it "should tell the user the task is running" do
      @output.should match(/Building Release/)
    end

    it "should prompt the user to install the submodule" do
      @output.should match(/Submodule for Github Pages isn't present/)
    end
  end

  describe "when the pages submodule is present" do
    before do
      JasmineDev.any_instance.should_receive(:write_version_files)
      JasmineDev.any_instance.should_receive(:build_distribution)
      JasmineDev.any_instance.should_receive(:build_standalone_distribution)
      JasmineDev.any_instance.should_receive(:build_github_pages)

      jasmine_dev.should_receive(:has_pages_submodule?).and_return(true)

      @output = capture_output { jasmine_dev.release_prep }
    end

    it "should tell the user the task is running" do
      @output.should match(/Building Release/)
    end
  end
end