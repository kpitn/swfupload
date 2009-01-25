module SwfuploadHelper

def swfupload_load(options)
  
  #Upload URL
  upload_url=options[:upload_url] || "/admin/photos/mass_update"
  file_size_limit=(options[:file_size_limit] || "10")+ " MB"
  file_types=options[:file_type] || "*.*" 
  file_upload_limit=options[:file_upload_limit].to_i || 100
  button_image_url=options[:button_image_url] || "/javascripts/swf/test_image.png"
  debug=options[:debug] || false
  form_id=options[:form_id] || "form"

  return_data=""
  return_data+=javascript_include_tag "swf/swfupload.js"
  return_data+=javascript_include_tag "swf/swfupload.queue.js"
  return_data+=javascript_include_tag "swf/fileprogress.js"
  return_data+=javascript_include_tag "swf/handlers.js"
  return_data+=<<-EOS
  <script type="text/javascript">
    var swfu;
    var isIE = false;
    window.onload = function() {
      var settings = {
        flash_url : "/javascripts/swf/swfupload.swf",
        upload_url: "#{upload_url}",
        post_params : {"authenticity_token" : "#{form_authenticity_token}","_session_id":"#{session.session_id}"},
        file_size_limit : "#{file_size_limit}",
        file_types : "#{file_types}",
        file_types_description : "All Files",
        file_upload_limit : #{file_upload_limit},
        file_queue_limit : 0,
        custom_settings : {
          progressTarget : "fsUploadProgress",
          cancelButtonId : "btnCancel"
        },
        debug: #{debug},

        // Button settings
        button_image_url: "#{button_image_url}",
        button_width: "65",
        button_height: "29",
        button_placeholder_id: "spanButtonPlaceHolder",
        button_text: '<span class="theFont">Hello</span>',
        button_text_style: ".theFont { font-size: 16; }",
        button_text_left_padding: 12,
        button_text_top_padding: 3,

        // The event handler functions are defined in handlers.js
        file_queued_handler : fileQueued,
        file_queue_error_handler : fileQueueError,
        file_dialog_complete_handler : fileDialogComplete,
        upload_start_handler : uploadStart,
        upload_progress_handler : uploadProgress,
        upload_error_handler : uploadError,
        upload_success_handler : uploadSuccess,
        upload_complete_handler : uploadComplete,
        queue_complete_handler : queueComplete	// Queue plugin event
      };

      swfu = new SWFUpload(settings);
    };

    function uploadSuccess(fileObj,data) {
      eval(data);
    }
    function uploadStart(){
      //add fom parameters
      var datas = $("#{form_id}").serializeArray();
      for (var i = 0; i < datas.length; i++) {
       swfu.addPostParam(datas[i].name,datas[i].value);
      }
    }
  </script>
  EOS
  return_data
  end
end