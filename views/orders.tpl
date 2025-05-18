% rebase('layout.tpl', title='Orders', year=year)

<link rel="stylesheet" href="/static/css/yumashkin.css">
<div class="container">
    <h1>Order Management</h1>
    
    <!-- Order creation form -->
    <div class="order-form">
        <h3>Create New Order</h3>
        <form method="POST" action="/orders">
            <div class="form-group">
                <label class="form-label">Order Number:</label>
                <input type="text" name="order_number" class="form-control" 
                       value="{{order_number or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Customer Name:</label>
                <input type="text" name="client_name" class="form-control" 
                       value="{{client_name or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Customer Phone:</label>
                <input type="tel" name="phone" class="form-control" 
                       value="{{phone or ''}}" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Order Description:</label>
                <textarea name="description" class="form-control" rows="3" 
                          required>{{description or ''}}</textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">Add Order</button>
        </form>
    </div>

    <!-- Error display -->
    % if errors:
    <div class="alert alert-danger">
        <h4>Errors:</h4>
        <ul>
            % for error in errors:
            <li>{{error}}</li>
            % end
        </ul>
    </div>
    % end

    <!-- Orders list -->
    <h2>Recent Orders</h2>
    % if not orders:
    <p>No orders available</p>
    % else:
    % for order in orders:
    <div class="order-card">
        <div class="order-header">
            <span class="order-number">Order #{{order.get('order_number', '')}}</span>
            <span class="order-date">{{order.get('order_date', '')}}</span>
        </div>
        <div class="order-client"><strong>Customer:</strong> {{order.get('client_name', '')}}</div>
        <div class="order-phone"><strong>Phone:</strong> {{order.get('phone', '')}}</div>
        <div class="order-description">
            {{order.get('description', '')}}
        </div>
    </div>
    % end
    % end
</div>