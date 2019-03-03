class WebhooksController < ApplicationController
  def github
    if (git_event = GithubEvent.create github_event_params) && git_event.id
      render json: { success: true }, status: 201
    else
      render json: { success: false, msg: git_event.errors.messages},
             status: 500
    end
  end

  private

  def github_event_params
    if event['headers'] && event['body']
      {
        github_id: event['headers']['X-GitHub-Delivery'],
        event: event['headers']['X-GitHub-Event'],
        payload: JSON.parse(event['body'])
      }
    else
      {}
    end
  end
end
