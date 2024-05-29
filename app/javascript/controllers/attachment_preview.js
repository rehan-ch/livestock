$(document).on('turbo:load', function() {
  function readURL(input, target) {
    const previewContainer = $(target);
    previewContainer.empty();

    if (!input.files || input.files.length === 0) {
      return;
    }

    Array.from(input.files).forEach(file => {
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
      };
      reader.readAsDataURL(file);
    });
  }

  $('.image-preview-input').off('change');

  $('.image-preview-input').on('change', function() {
    const target = $(this).data('preview-target');
    readURL(this, target);
  });
});

