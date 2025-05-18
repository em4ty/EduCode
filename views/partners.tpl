% rebase('layout.tpl', title='Partner Companies', year=year)

<link rel="stylesheet" href="/static/css/yumashkin.css">

<div class="container">
    <h1>Partner Companies</h1>
    
    <div class="partner-form">
        <h3>Add Partner</h3>
        <form method="POST" action="/partners">
            <div class="form-group">
                <label>Company Name:</label>
                <input type="text" name="company_name" class="form-control" value="{{company_name or ''}}" required>
            </div>
            <div class="form-group">
                <label>Contact Person:</label>
                <input type="text" name="contact_person" class="form-control" value="{{contact_person or ''}}" required>
            </div>
            <div class="form-group">
                <label>Phone:</label>
                <input type="tel" name="phone" class="form-control" value="{{phone or ''}}" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" value="{{email or ''}}" required>
            </div>
            <button type="submit" class="btn btn-primary">Add</button>
        </form>
    </div>

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

    <h2>Partners List</h2>
    % if not partners:
    <p>No partner data available</p>
    % else:
    % for partner in partners:
    <div class="partner-card">
        <div class="partner-header">
            <span class="partner-name">{{partner.get('company_name', '')}}</span>
        </div>
        <div class="partner-contact">
            <strong>Contact:</strong> {{partner.get('contact_person', '')}}<br>
            <strong>Phone:</strong> {{partner.get('phone', '')}}<br>
            <strong>Email:</strong> {{partner.get('email', '')}}
        </div>
    </div>
    % end
    % end
</div>