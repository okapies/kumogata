describe 'Kumogata::Client#delete' do
  it 'update a stack from Ruby template' do
    run_client(:delete, :arguments => ['MyStack'], :options => {:force => true}) do |client, cf|
      client.should_receive(:print_event_log).once
      client.should_receive(:create_event_log).once

      stack = make_double('stack') do |obj|
        obj.should_receive(:delete).with(no_args())
        obj.should_receive(:status).and_return(
            'DELETE_COMPLETE', 'DELETE_COMPLETE', 'DELETE_COMPLETE')
      end

      stacks = make_double('stacks') do |obj|
        obj.should_receive(:[])
           .with('MyStack') { stack }
      end

      cf.should_receive(:stacks) { stacks }
    end
  end
end
