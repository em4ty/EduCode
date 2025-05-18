% rebase('layout.tpl', title='Order Management - Tovstogan', year=year)

<link rel="stylesheet" href="/static/css/tovstogan.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<div class="container tovstogan-orders-container">
    <h1 class="tovstogan-orders-header">
        <i class="fas fa-shopping-cart"></i> Order Management
    </h1>
    
    <!-- Order form with Tovstogan styling -->
    <div class="tovstogan-order-form">
        <h3 class="tovstogan-form-title">
            <i class="fas fa-plus-circle"></i> Create New Order
        </h3>
        <form method="POST" action="/orders_tovsa" class="tovstogan-form">
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-hashtag"></i> Order Number:
                </label>
                <input type="text" name="order_number" class="form-control tovstogan-input {{'is-invalid' if 'Укажите номер заказа' in errors else ''}}" 
                       value="{{order_number or ''}}" required>
                % if 'Укажите номер заказа' in errors:
                <div class="invalid-feedback">Please provide an order number</div>
                % end
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-user"></i> Customer Name:
                </label>
                <input type="text" name="client_name" class="form-control tovstogan-input {{'is-invalid' if 'Укажите имя клиента' in errors else ''}}" 
                       value="{{client_name or ''}}" required>
                % if 'Укажите имя клиента' in errors:
                <div class="invalid-feedback">Please provide a customer name</div>
                % end
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-phone"></i> Customer Phone:
                </label>
                <input type="tel" name="phone" class="form-control tovstogan-input {{'is-invalid' if 'Укажите телефон клиента' in errors else ''}}" 
                       value="{{phone or ''}}" 
                       placeholder="+79161234567 or 89161234567" required>
                % if 'Укажите телефон клиента' in errors:
                <div class="invalid-feedback">Please provide a valid Russian phone number (+79161234567 or 89161234567)</div>
                % end
            </div>
            
            <div class="form-group">
                <label class="tovstogan-form-label">
                    <i class="fas fa-align-left"></i> Order Description:
                </label>
                <textarea name="description" class="form-control tovstogan-textarea {{'is-invalid' if 'Укажите описание заказа' in errors else ''}}" 
                          rows="3" required>{{description or ''}}</textarea>
                % if 'Укажите описание заказа' in errors:
                <div class="invalid-feedback">Please provide an order description</div>
                % end
            </div>
            
            <button type="submit" class="btn btn-info tovstogan-submit-btn">
                <i class="fas fa-save"></i> Add Order
            </button>
        </form>
    </div>

    <!-- Error display with Tovstogan styling -->
    % if errors:
    <div class="alert alert-warning tovstogan-alert">
        <h4><i class="fas fa-exclamation-triangle"></i> Errors:</h4>
        <ul class="tovstogan-error-list">
            % for error in errors:
            <li>{{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Orders list with Tovstogan styling -->
    <h2 class="tovstogan-section-title">
        <i class="fas fa-list-ol"></i> Recent Orders
    </h2>
    % if not orders:
    <p class="tovstogan-empty-message">
        <i class="far fa-frown"></i> No orders available
    </p>
    % else:
    % for order in orders:
    <div class="tovstogan-order-card">
        <div class="tovstogan-order-header">
            <span class="tovstogan-order-number">
                <i class="fas fa-hashtag"></i> Order #{{order.get('order_number', '')}}
            </span>
            <span class="tovstogan-order-date">
                <i class="far fa-calendar-alt"></i> {{order.get('order_date', '')}}
            </span>
        </div>
        <div class="tovstogan-order-client">
            <strong><i class="fas fa-user"></i> Customer:</strong> {{order.get('client_name', '')}}
        </div>
        <div class="tovstogan-order-phone">
            <strong><i class="fas fa-phone"></i> Phone:</strong> {{order.get('phone', '')}}
        </div>
        <div class="tovstogan-order-description">
            <strong><i class="fas fa-info-circle"></i> Details:</strong> 
            {{order.get('description', '')}}
        </div>
    </div>
    % end
    % end
</div>

<script>
document.querySelector('form').addEventListener('submit', function(e) {
    const phone = document.querySelector('input[name="phone"]').value;
    const phoneRegex = /^(\+7|8)\d{10}$/;
    const cleanedPhone = phone.replace(/[^\d+]/g, '');
    
    if (!phoneRegex.test(cleanedPhone)) {
        e.preventDefault();
        alert('Please enter a valid Russian phone number (+79161234567 or 89161234567)');
    }
});
</script>