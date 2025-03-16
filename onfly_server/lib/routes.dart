import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:onfly_api/controllers/auth_controller.dart';
import 'package:onfly_api/controllers/expense_controller.dart';
import 'package:onfly_api/utils/auth_middleware.dart';

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
    const Pipeline()
        .addMiddleware(authenticateRequests())
        .addHandler(expenseRouter.call),
  );

  return router;
}
