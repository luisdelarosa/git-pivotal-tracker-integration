# Git Pivotal Tracker Integration
# Copyright (c) 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "git-pivotal-tracker-integration/base"
require "spec_helper"

describe Base do
  before do
    PivotalConfiguration.should_receive(:api_token).and_return("test_api_token")
    PivotalConfiguration.should_receive(:project_id).and_return("test_project_id")
    PivotalTracker::Client.stub!(:token, :use_ssl)
    PivotalTracker::Project.stub!(:find)
  end

  it "should return the current branch" do
    base = Stub.new()
    base.should_receive(:`).with("git branch").and_return("   master\n * test_branch")

    current_branch = base.current_branch_stub

    expect(current_branch).to eq("test_branch")
  end
end

class Stub < Base

  def current_branch_stub
    current_branch
  end

end
