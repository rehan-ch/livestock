$(document).on('turbo:load', function() {
  function readURL(input, target) {
    const previewContainer = $(target);
    previewContainer.empty();

    if (input.files && input.files.length > 0) {
      for (let i = 0; i < input.files.length; i++) {
        const file = input.files[i];
        const reader = new FileReader();

        reader.onload = function(e) {
          const img = $('<img/>', {
            src: e.target.result,
            class: 'preview-image',
            css: {
              maxWidth: '200px',
              maxHeight: '200px',
              margin: '10px'
            }
          });
          previewContainer.append(img);
        }

        reader.readAsDataURL(file);
      }
    }
  }

  $(document).on('change', '.image-preview-input', function() {
    const target = $(this).data('preview-target');
    readURL(this, target);
  });
});
