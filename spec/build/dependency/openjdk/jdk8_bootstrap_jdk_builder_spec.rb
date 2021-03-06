# Encoding: utf-8
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

require 'spec_helper'
require 'console_helper'
require 'build/dependency/openjdk/jdk8_bootstrap_jdk_builder'
require 'English'

describe Build::Dependency::JDK8BootstrapJDKBuilder do
  include_context 'console_helper'

  let(:builder) { described_class.new }

  let(:root) { File.expand_path('vendor/openjdk/bootstrap-jdk') }

  it 'should return a root location' do
    expect(builder.root).to eq(root)
  end

  it 'should not download if already exists' do
    expect(File).to receive(:exist?).with(root).and_return(true)
    expect(described_class).not_to receive(:system)

    builder.build
  end

  it 'should not download if on macosx' do
    expect(File).to receive(:exist?).with(root).and_return(false)
    expect(builder).to receive(:macosx?).and_return(true)
    expect(builder).not_to receive(:system)

    builder.build
  end

  it 'should download from internet' do
    expect(File).to receive(:exist?).with(root).and_return(false)
    expect(builder).to receive(:macosx?).and_return(false)
    expect(FileUtils).to receive(:mkdir_p).with(root)
    expect(builder).to receive(:system)

    builder.build
  end

end
