% rebase('layout.tpl', title=title, year=year)

<div class="container yumashkin-container">
    <h1 class="text-center yumashkin-header">{{title}}</h1>
    
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Добавить новый</h3>
                </div>
                <div class="panel-body">
                    <form method="POST" action="{{action_url}}" class="yumashkin-form">
                        {{!form_fields()}}
                        <div class="form-group">
                            <button type="submit" class="btn btn-success btn-block">
                                <i class="glyphicon glyphicon-plus"></i> {{submit_text}}
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            % if errors:
            <div class="alert alert-danger">
                <ul>
                    % for error in errors:
                    <li>{{error}}</li>
                    % end
                </ul>
            </div>
            % end

            <div class="items-list">
                <h3 class="text-center">Список</h3>
                {{!items_list()}}
            </div>
        </div>
    </div>
</div>