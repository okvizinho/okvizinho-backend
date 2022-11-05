module Types
    class Models::AttachmentType < Types::BaseObject
      field :id, ID, null: false
      field :url, String, null: true
      field :variant, String, null: true do
        argument :resize, String, required: true
      end
  
      def url
        Rails.application.routes.url_helpers.rails_blob_url(file)
      end
  
      def variant(params)
        return Rails.application.routes.url_helpers.url_for(object.file.preview(resize: params[:resize])) unless file.variable?
        Rails.application.routes.url_helpers.rails_representation_url(file.variant(resize: params[:resize]))
      end
  
      def file
        object.respond_to?(:file) ? object.file : object
      end
    end
end