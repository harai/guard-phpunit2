require 'spec_helper'

describe Guard::PHPUnit2::Formatter do
  describe '.parse_output' do
    context 'when all tests pass' do
      it 'returns a hash containing the tests result' do
        output = load_phpunit_output('passing')
        subject.parse_output(output).should == {
          :tests  => 2, :failures => 0,
          :errors => 0, :pending  => 0,
          :duration => [0, "seconds"]
        }
      end
    end
    
    context 'when a single test passes' do
      it 'returns a hash containing the test result' do
        output = load_phpunit_output('passing1')
        subject.parse_output(output).should == {
          :tests  => 1, :failures => 0,
          :errors => 0, :pending  => 0,
          :duration => [0, "seconds"]
        }
      end
    end
    
    context 'when all tests fail' do
      it 'returns a hash containing the tests result' do
        output = load_phpunit_output('failing')
        subject.parse_output(output).should == {
          :tests  => 2, :failures => 2,
          :errors => 0, :pending  => 0,
          :duration => [0, "seconds"]
        }
      end
    end

    context 'when tests are skipped or incomplete' do
      it 'returns a hash containing the tests result' do
        output = load_phpunit_output('skipped_and_incomplete')
        subject.parse_output(output).should == {
          :tests  => 3, :failures => 0,
          :errors => 0, :pending  => 3,
          :duration => [0, "seconds"]
        }
      end
    end

    context 'when tests have mixed statuses' do
      it 'returns a hash containing the tests result' do
        output = load_phpunit_output('mixed')
        subject.parse_output(output).should == {
          :tests  => 13, :failures => 3,
          :errors => 1, :pending  => 3,
          :duration => [2, "seconds"]
        }
      end
    end
  end
end
