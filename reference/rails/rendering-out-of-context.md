Most Rails renders are synchronous responses to user requests. In these synchronous contexts, the `render` method is defined and an `ActionView::Context` is present. We need these two things to render Phlex components.

However, these two things are not always present. How can we render Phlex components in an ActiveRecord callback? How can we render in a background job? The answer is to use `ApplicationController.render_to_string`.

Example 1: rendering a Phlex component for a Turbo Stream in response to an ActiveRecord callback:

```
class Post < ApplicationRecord
  after_create_commit {
    model = self
    component = Components::MyPostComponent.new(post: model)
    # Setting the request is not always required, but common Rails features
    # including path helpers fail without it.
    fake_rack_request = Rack::MockRequest.env_for("http://localhost", method: :get)
    controller.request = ActionDispatch::Request.new(fake_rack_request)
    html = controller.render_to_string(component, layout: false)
    broadcast_prepend_to("my-streamable", html:)
  }
end
```

Example 2: rendering a Phlex component in a background job:
```
class MailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    model = Post.create!
    component = Components::MyPostComponent.new(post: model)
    fake_rack_request = Rack::MockRequest.env_for("http://localhost", method: :get)
    controller.request = ActionDispatch::Request.new(fake_rack_request)
    html = controller.render_to_string(component, layout: false)
    HelloMailer.with(html:).hello_email.deliver_now
  end
end
```

You might find it convenient to define a helper like this:
```
module PhlexRenderer
  def render_phlex_to_string(phlex_component)
    throw "Argument must be a Phlex component" unless phlex_component.is_a?(Components::Base)

    controller = ApplicationController.new
    fake_rack_request = Rack::MockRequest.env_for("http://localhost", method: :get)
    controller.request = ActionDispatch::Request.new(fake_rack_request)
    controller.render_to_string(phlex_component, layout: false)
  end
end
```
