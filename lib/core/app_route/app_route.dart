import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/screens/home/detail_document_screen.dart';
import 'package:edoc_tabcom/screens/home/home_screen.dart';
import 'package:edoc_tabcom/screens/home/view_pdf_file_modal.dart';
import 'package:edoc_tabcom/screens/my_document/my_document_screen.dart';
import 'package:edoc_tabcom/screens/system_management/create_group_screen.dart';
import 'package:edoc_tabcom/screens/system_management/document_management_screen.dart';
import 'package:edoc_tabcom/screens/system_management/system_management_list_screen.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';
import 'package:edoc_tabcom/screens/authentication/change_password_screen.dart';
import 'package:edoc_tabcom/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import '../../screens/account/personal_view_screen.dart';
import '../../screens/authentication/forget_password_screen.dart';
import '../../screens/authentication/login_screen.dart';
import '../../screens/authentication/otp_confirm_screen.dart';
import '../../screens/authentication/register_screen.dart';
import '../../screens/authentication/reset_password_screen.dart';
import '../../screens/authentication/welcome_screen.dart';
import '../../screens/home/ai_agent_screen.dart';
import '../../screens/home/ai_document_genarator_screen.dart';
import '../../screens/home/ai_document_preview_screen.dart';
import '../../screens/home/ai_improve_text_preview_screen.dart';
import '../../screens/home/ai_improve_text_screen.dart';
import '../../screens/home/aichatbot_screen.dart';
import '../../screens/home/scan_doc_from_image_screen.dart';
import '../../screens/notification/notification_dashboard_screen.dart';
import '../../screens/account/my_account_tab.dart';
import '../../screens/system_management/group_management_screen.dart';
import 'package:edoc_tabcom/screens/system_management/create_document_screen.dart';
import 'app_route_guard.dart';
part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthProvider _tokenNotifier;
  AppRouter(this._tokenNotifier);
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: TabRoute.page,
            guards: [RouteGuard(_tokenNotifier)],
            path: '/',
            children: [
              AutoRoute(page: HomeRoute.page, path: 'home'),
              AutoRoute(page: MyDocumentRoute.page, path: 'my-document'),
              AutoRoute(
                  page: NotificationProductRoute.page,
                  path: 'notification-dashboard'),
              AutoRoute(page: MyAccountTabRoute.page, path: 'account'),
              AutoRoute(
                  page: SystemManagementListRoute.page,
                  path: 'system-management'),
            ]),
        AutoRoute(page: DetailDocumentRoute.page, path: '/detail-document/:id'),
        AutoRoute(page: ChangePasswordRoute.page, path: '/change-password'),
        AutoRoute(page: PersonalViewRoute.page, path: '/personal-view'),
        AutoRoute(
            page: DocumentManagementRoute.page, path: '/document-management'),
        AutoRoute(page: CreateDocumentRoute.page, path: '/create-document'),
        AutoRoute(page: CreateGroupRoute.page, path: '/create-group'),
        AutoRoute(page: GroupManagementRoute.page, path: '/group-management'),
        AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: OTPConfirmRoute.page, path: '/otp-confirm'),
        AutoRoute(page: ResetPasswordRoute.page, path: '/reset-password'),
        AutoRoute(page: ForgotPasswordRoute.page, path: '/forgot-password'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        CustomRoute(page: ViewPdfFileRoute.page, path: '/view-pdf-file'),
        CustomRoute(
          page: AichatbotRoute.page,
          path: '/aichatbot/:fileId',
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 200,
        ),
        CustomRoute(
          page: AIAgentRoute.page,
          path: '/ai-agent',
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 200,
        ),
        CustomRoute(
          page: AITextRefactorRoute.page,
          path: '/ai-text-refactor',
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 200,
        ),
        CustomRoute(
          page: AIDocumentGenaratorRoute.page,
          path: '/ai-document-genarator',
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 200,
        ),
        CustomRoute(
          page: AIDocumentPreviewRoute.page,
          path: '/ai-document-preview',
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 200,
        ),
        CustomRoute(
          page: AIImproveTextPreviewRoute.page,
          path: '/ai-improve-text-preview',
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 200,
        ),
        CustomRoute(
          page: ScanDocFromImageRoute.page,
          path: '/scan-doc-from-image',
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 200,
        ),

        /// routes go here
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}
