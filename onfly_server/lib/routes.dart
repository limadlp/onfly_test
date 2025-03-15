import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'controllers/auth_controller.dart';
import 'controllers/expense_controller.dart';
import 'utils/auth_middleware.dart';

Router setupRoutes() {
  final router = Router();

  // Authentication endpoints
  router.post('/auth/signup', AuthController().signUp);
  router.post('/auth/signin', AuthController().signIn);

  // Expense endpoints with authentication
  final expenseRouter =
      Router()
        ..get('/', ExpenseController().getAllExpenses)
        ..get('/<id>', ExpenseController().getExpenseById)
        ..post('/', ExpenseController().addExpense)
        ..put('/<id>', ExpenseController().updateExpense)
        ..delete('/<id>', ExpenseController().deleteExpense)
        ..post('/upload', ExpenseController().uploadReceipt);

  // Apply authentication middleware only to /expenses
  router.mount(
    '/expenses',
    Pipeline().addMiddleware(authenticateRequests()).addHandler(expenseRouter),
  );

  return router;
}
