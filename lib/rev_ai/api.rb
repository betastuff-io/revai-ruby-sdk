module RevAI
    class Api
        PRODUCTION_HOST = 'https://api.rev.ai/speechtotext/v1'.freeze
        TRANSCRIPT_FORMAT = 'application/vnd.rev.transcript.v1.0+json'.freeze
    
        include HTTParty
    
        def initialize(access_token:, endpoint:)
          self.class.base_uri(endpoint)
          self.class.headers(
            Authorization: "Bearer #{access_token}",
            'Content-Type': 'application/json'
          )
        end
    
        def send_transcription_request(params:)
          self.class.post('/jobs', body: params.to_json)
        end
    
        def get_transcript(job_id:)
          response = self.class.get("/jobs/#{job_id}/transcript", headers: { accept: TRANSCRIPT_FORMAT })
          Transcript.new(raw: JSON.parse(response))
        end
    end
end