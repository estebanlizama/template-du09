/**
 * UFRO PDS Workflow Modernization - Custom Dialogs System
 * Replaces standard browser alert() and confirm() with premium, institutional UI components.
 */

(function() {
    // Inject Toast Container on page load
    $(document).ready(function() {
        if ($('#ufro-toast-container').length === 0) {
            $('body').append('<div id="ufro-toast-container"></div>');
        }
    });

    // Custom Toast Notification System
    window.showToast = function(message, type = 'info', title = '') {
        if ($('#ufro-toast-container').length === 0) {
            $('body').append('<div id="ufro-toast-container"></div>');
        }

        const container = $('#ufro-toast-container');
        const toastId = 'toast-' + Math.random().toString(36).substr(2, 9);
        
        let icon = '<i class="fas fa-info-circle"></i>';
        let defaultTitle = 'Notificación';
        
        if (type === 'success') {
            icon = '<i class="fas fa-check-circle"></i>';
            defaultTitle = 'Éxito';
        } else if (type === 'warning') {
            icon = '<i class="fas fa-exclamation-triangle"></i>';
            defaultTitle = 'Advertencia';
        } else if (type === 'danger') {
            icon = '<i class="fas fa-times-circle"></i>';
            defaultTitle = 'Error';
        }
        
        const displayTitle = title || defaultTitle;
        
        const toastHtml = `
            <div id="${toastId}" class="ufro-toast ufro-toast-${type}">
                <div class="ufro-toast-icon">${icon}</div>
                <div class="ufro-toast-content">
                    <div class="ufro-toast-title">${displayTitle}</div>
                    <div class="ufro-toast-message">${message}</div>
                </div>
                <button type="button" class="ufro-toast-close" onclick="$(this).closest('.ufro-toast').removeClass('show').delay(400).queue(function() { $(this).remove(); });">
                    &times;
                </button>
            </div>
        `;
        
        container.append(toastHtml);
        
        // Trigger reflow & show animation
        const toastElement = $(`#${toastId}`);
        setTimeout(() => {
            toastElement.addClass('show');
        }, 50);
        
        // Auto remove toast after 5 seconds
        setTimeout(() => {
            if (toastElement.hasClass('show')) {
                toastElement.removeClass('show');
                setTimeout(() => {
                    toastElement.remove();
                }, 400);
            }
        }, 5000);
    };

    // Override original alert with toast
    window.alert = function(message) {
        let type = 'info';
        let title = 'Control Normativo PDS';
        
        // Detect validation errors/warnings in messages
        const lowerMsg = message.toLowerCase();
        if (lowerMsg.includes('error') || lowerMsg.includes('excede') || lowerMsg.includes('supera') || lowerMsg.includes('no permitido') || lowerMsg.includes('debe')) {
            type = 'danger';
            title = 'Validación Inválida';
        } else if (lowerMsg.includes('advertencia') || lowerMsg.includes('tope') || lowerMsg.includes('límite') || lowerMsg.includes('atención') || lowerMsg.includes('normativa')) {
            type = 'warning';
            title = 'Alerta de Control';
        } else if (lowerMsg.includes('éxito') || lowerMsg.includes('correcto') || lowerMsg.includes('exitosamente') || lowerMsg.includes('archivado')) {
            type = 'success';
            title = 'Acción Exitosa';
        }
        
        window.showToast(message, type, title);
    };

    // Custom Modal Confirmation System (replaces confirm)
    // Since native confirm is blocking and returns boolean, but custom UI modals are async,
    // we provide showConfirm as the async/callback alternative, and then replace calls manually
    // to give a beautiful user experience.
    window.showConfirm = function({
        title = 'Confirmar Acción',
        message = '¿Está seguro de realizar esta acción?',
        confirmText = 'CONFIRMAR',
        cancelText = 'CANCELAR',
        type = 'primary', // primary (blue), success (green), warning (orange), danger (red)
        onConfirm = () => {},
        onCancel = () => {}
    } = {}) {
        // Remove existing modal if any
        $('#ufro-dynamic-confirm').remove();
        
        let confirmBtnClass = 'btn-ufro-primary';
        let icon = '<i class="fas fa-question-circle mr-2"></i>';
        
        if (type === 'success') {
            confirmBtnClass = 'btn-ufro-success';
            icon = '<i class="fas fa-check-circle mr-2"></i>';
        } else if (type === 'warning') {
            confirmBtnClass = 'btn-ufro-warning';
            icon = '<i class="fas fa-exclamation-triangle mr-2"></i>';
        } else if (type === 'danger') {
            confirmBtnClass = 'btn-ufro-danger';
            icon = '<i class="fas fa-exclamation-circle mr-2"></i>';
        }
        
        const modalHtml = `
            <div class="modal fade ufro-confirm-modal" id="ufro-dynamic-confirm" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title font-weight-bold text-white">
                                ${icon} ${title}
                            </h5>
                            <button type="button" class="close text-white border-0 bg-transparent font-weight-bold" data-dismiss="modal" aria-label="Close" style="opacity: 0.8; outline: none; font-size: 1.2rem; cursor: pointer;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body text-left">
                            <p class="font-weight-bold text-dark mb-0" style="font-size: 0.95rem; line-height: 1.6;">
                                ${message}
                            </p>
                        </div>
                        <div class="modal-footer d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-ufro-secondary mr-2" id="ufro-confirm-cancel-btn" data-dismiss="modal">
                                ${cancelText}
                            </button>
                            <button type="button" class="btn ${confirmBtnClass}" id="ufro-confirm-ok-btn">
                                ${confirmBtnText}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        $('body').append(modalHtml);
        const modal = $('#ufro-dynamic-confirm');
        
        // Show modal
        modal.modal('show');
        
        // Bind confirm button click
        $('#ufro-confirm-ok-btn').off('click').on('click', function() {
            modal.modal('hide');
            setTimeout(() => {
                onConfirm();
                modal.remove();
            }, 300);
        });
        
        // Bind cancel/dismiss click
        modal.on('hidden.bs.modal', function(e) {
            onCancel();
            modal.remove();
        });
    };
})();
