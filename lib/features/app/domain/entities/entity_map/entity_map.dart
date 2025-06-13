import 'package:work_diary/features/app/domain/entities/areas.dart';
import 'package:work_diary/features/app/domain/entities/attendance_response.dart';
import 'package:work_diary/features/app/domain/entities/chart_response.dart';
import 'package:work_diary/features/app/domain/entities/children_response.dart';
import 'package:work_diary/features/app/domain/entities/companies.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/dashboard_response.dart';
import 'package:work_diary/features/app/domain/entities/dealer_company.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/district.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_details_response.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_pagination.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_response.dart';
import 'package:work_diary/features/app/domain/entities/forms_response.dart';
import 'package:work_diary/features/app/domain/entities/login_response.dart';
import 'package:work_diary/features/app/domain/entities/performance_report.dart';
import 'package:work_diary/features/app/domain/entities/plan_details.dart';
import 'package:work_diary/features/app/domain/entities/plan_list_response.dart';
import 'package:work_diary/features/app/domain/entities/slot_response.dart';
import 'package:work_diary/features/app/domain/entities/source_response.dart';
import 'package:work_diary/features/app/domain/entities/started_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_pagination.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';
import 'package:work_diary/features/app/domain/entities/unit_details.dart';
import 'package:work_diary/features/app/domain/entities/unit_save_response.dart';
import 'package:work_diary/features/app/domain/entities/unit_type.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/entities/units_get_conditional_fields.dart';
import 'package:work_diary/features/app/domain/entities/upazilas.dart';
import 'package:work_diary/features/app/domain/entities/update_visit.dart';
import 'package:work_diary/features/app/domain/entities/user_profile.dart';
import 'package:work_diary/features/app/domain/entities/verify_otp_response.dart';
import 'package:work_diary/features/app/domain/entities/visit.dart';
import 'package:work_diary/features/app/domain/entities/visit_confirmation_response.dart';
import 'package:work_diary/features/app/domain/entities/visit_objective.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';
import 'package:work_diary/features/app/domain/entities/visitors.dart';
import 'package:work_diary/features/app/domain/entities/zone.dart';

class EntityMap {
  static T? fromJson<T, K>(dynamic json) {
    switch (T) {
      case LoginResponse:
        return LoginResponse.fromJson(json) as T;
      case Companies:
        return Companies.fromJson(json) as T;
      case Company:
        return Company.fromJson(json) as T;
      case DefaultResponse:
        return DefaultResponse.fromJson(json) as T;
      case VerifyOtpResponse:
        return VerifyOtpResponse.fromJson(json) as T;
      case UnitResponse:
        return UnitResponse.fromJson(json) as T;
      case UserDetails:
        return UserDetails.fromJson(json) as T;
      case Zones:
        return Zones.fromJson(json) as T;
      case UnitTypes:
        return UnitTypes.fromJson(json) as T;
      case VisitObjectives:
        return VisitObjectives.fromJson(json) as T;
      case Visitors:
        return Visitors.fromJson(json) as T;
      case VisitStatus:
        return VisitStatus.fromJson(json) as T;
      case TodaysVisitResponse:
        return TodaysVisitResponse.fromJson(json) as T;
      case TodaysVisitPagination:
        return TodaysVisitPagination.fromJson(json) as T;
      case EmergencyTaskResponse:
        return EmergencyTaskResponse.fromJson(json) as T;
      case EmergencyTaskPagination:
        return EmergencyTaskPagination.fromJson(json) as T;
      // case VisitDetails:
      //   return VisitDetails.fromJson(json) as T;
      case FormsResponse:
        return FormsResponse.fromJson(json) as T;
      case SourceResponse:
        return SourceResponse.fromJson(json) as T;
      case SourceObject:
        return SourceObject.fromJson(json) as T;
      case Visits:
        return Visits.fromJson(json) as T;
      case StartedVisitList:
        return StartedVisitList.fromJson(json) as T;
      case AttendanceResponse:
        return AttendanceResponse.fromJson(json) as T;
      case CompleteVisitResponse:
        return CompleteVisitResponse.fromJson(json) as T;
      case EmergencyTaskDetails:
        return EmergencyTaskDetails.fromJson(json) as T;
      case UpdateVisit:
        return UpdateVisit.fromJson(json) as T;
      case DashboardResponse:
        return DashboardResponse.fromJson(json) as T;
      case VisitConfirmationResponse:
        return VisitConfirmationResponse.fromJson(json) as T;
      case SlotResponse:
        return SlotResponse.fromJson(json) as T;
      case ChartResponse:
        return ChartResponse.fromJson(json) as T;
      case UnitType:
        return UnitType.fromJson(json) as T;
      case DistrictList:
        return DistrictList.fromJson(json) as T;
      case Upazilas:
        return Upazilas.fromJson(json) as T;
      case DealerCompany:
        return DealerCompany.fromJson(json) as T;
      case Areas:
        return Areas.fromJson(json) as T;
      case UnitSaveResponse:
        return UnitSaveResponse.fromJson(json) as T;
      case UnitDetails:
        return UnitDetails.fromJson(json) as T;
      case UnitsConditionalFields:
        return UnitsConditionalFields.fromJson(json) as T;
      case ChildrenResponse:
        return ChildrenResponse.fromJson(json) as T;
      case PlanDetailsResponse:
        return PlanDetailsResponse.fromJson(json) as T;
      case PlanListResponse:
        return PlanListResponse.fromJson(json) as T;
      case PerformanceReport:
        return PerformanceReport.fromJson(json) as T;

      default:
        throw Exception('Unknown class');
    }
  }
}
