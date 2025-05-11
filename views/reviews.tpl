% rebase('layout.tpl', title='Отзывы', year=year)

<style>
    /* Основные стили для всей страницы */
    .container {
        color: #000000; /* Чёрный цвет для всего текста в контейнере */
    }
    
    /* Стили для отзывов */
    .review-item {
        color: #000000;  /* Чёрный цвет текста */
        background-color: #ffffff;  /* Белый фон */
        border: 1px solid #dddddd;  /* Граница */
        margin-bottom: 15px;
        padding: 15px;
        border-radius: 5px;
    }
    .review-author {
        color: #000000; /* Чёрный цвет */
        font-weight: bold;
        font-size: 1.2em;
        margin-bottom: 5px;
    }
    .review-date {
        color: #000000; /* Чёрный цвет (был #666) */
        font-size: 0.9em;
        opacity: 0.8; /* Лёгкая прозрачность для даты */
    }
    .review-text {
        color: #000000; /* Чёрный цвет */
        margin-top: 10px;
        line-height: 1.5;
    }
    
    /* Стили для формы */
    .well {
        color: #000000; /* Чёрный цвет текста в форме */
    }
    .form-control {
        color: #000000; /* Чёрный цвет в input */
    }
    label {
        color: #000000; /* Чёрный цвет для меток */
    }
    
    /* Заголовки */
    h1, h2, h3 {
        color: #000000; /* Чёрный цвет для заголовков */
    }
    
    /* Сообщение когда нет отзывов */
    .no-reviews {
        color: #000000; /* Чёрный цвет */
    }
</style>

<div class="container">
    <h1>Отзывы о курсах</h1>
    
    <!-- Форма добавления отзыва -->
    <div class="well" style="margin-bottom: 30px;">
        <h3>Добавить отзыв</h3>
        <form method="POST" action="/reviews">
            <div class="form-group">
                <label>Ваше имя:</label>
                <input type="text" name="author" class="form-control" value="{{author or ''}}" required>
            </div>
            
            <div class="form-group">
                <label>Текст отзыва:</label>
                <textarea name="text" class="form-control" rows="4" required>{{text or ''}}</textarea>
            </div>
            
            <div class="form-group">
                <label>Дата:</label>
                <input type="date" name="date" class="form-control" value="{{date or ''}}" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Отправить отзыв</button>
        </form>
    </div>

    <!-- Список отзывов -->
    <h2>Последние отзывы</h2>
    % if not reviews:
    <p class="no-reviews">Пока нет отзывов. Будьте первым!</p>
    % else:
    % for review in reviews:
    <div class="review-item">
        <div class="review-author">{{review.get('author', 'Аноним')}}</div>
        <div class="review-date">{{review.get('date', '')}}</div>
        <div class="review-text">{{review.get('text', '')}}</div>
    </div>
    % end
    % end
</div>