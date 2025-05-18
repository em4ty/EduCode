% rebase('layout.tpl', title=title, year=year)

<!-- Tovstogan Design System -->
<link rel="stylesheet" href="/static/css/tovstogan.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<div class="container tovstogan-container">
    <!-- Page Header with Tovstogan Branding -->
    <div class="tovstogan-header-container">
        <h1 class="text-center tovstogan-header">
            <i class="fas fa-user-tie tovstogan-brand-icon"></i> {{title}}
        </h1>
        <div class="tovstogan-brand-line"></div>
    </div>
    
    <!-- Centered Content Grid -->
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <!-- Add Item Panel -->
            <div class="panel tovstogan-panel">
                <!-- Panel Header -->
                <div class="panel-heading tovstogan-panel-heading">
                    <h3 class="panel-title tovstogan-panel-title">
                        <i class="fas fa-plus-circle"></i> Add New Item
                    </h3>
                </div>
                
                <!-- Panel Body with Form -->
                <div class="panel-body tovstogan-panel-body">
                    <form method="POST" action="{{action_url}}" class="tovstogan-form">
                        <!-- Dynamic Form Fields -->
                        {{!form_fields()}}
                        
                        <!-- Form Submit Button -->
                        <div class="form-group tovstogan-form-group">
                            <button type="submit" class="btn tovstogan-btn tovstogan-btn-submit btn-block">
                                <i class="fas fa-cloud-upload-alt"></i> {{submit_text}}
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Error Display Section -->
            % if errors:
            <div class="tovstogan-alert tovstogan-alert-warning">
                <div class="tovstogan-alert-icon">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <div class="tovstogan-alert-content">
                    <h4>Validation Errors</h4>
                    <ul class="tovstogan-error-list">
                        % for error in errors:
                        <li>
                            <i class="fas fa-angle-right"></i> {{error}}
                        </li>
                        % end
                    </ul>
                </div>
            </div>
            % end

            <!-- Items List Section -->
            <div class="tovstogan-items-section">
                <div class="tovstogan-section-header">
                    <i class="fas fa-th-list tovstogan-section-icon"></i>
                    <h3 class="tovstogan-section-title">Items List</h3>
                </div>
                
                <!-- Dynamic Items List -->
                <div class="tovstogan-items-container">
                    {{!items_list()}}
                </div>
                
                % if not items_list():
                <div class="tovstogan-empty-state">
                    <i class="far fa-folder-open"></i>
                    <p>No items found. Create your first item!</p>
                </div>
                % end
            </div>
        </div>
    </div>
</div>

<!-- Tovstogan Brand Footer -->
<div class="tovstogan-footer">
    <div class="container">
        <p class="text-center">
            <i class="fas fa-user-tie"></i> Tovstogan Management System
        </p>
    </div>
</div>