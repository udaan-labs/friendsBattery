// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_employee_detail_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminEmployeeDetailData extends AdminEmployeeDetailData {
  @override
  final ShopStaffMember? employee;
  @override
  final bool? isCheckedIn;
  @override
  final AdminEmployeeDetailDataCurrentAttendance? currentAttendance;
  @override
  final BuiltList<EmployeeAction>? actions;

  factory _$AdminEmployeeDetailData([
    void Function(AdminEmployeeDetailDataBuilder)? updates,
  ]) => (AdminEmployeeDetailDataBuilder()..update(updates))._build();

  _$AdminEmployeeDetailData._({
    this.employee,
    this.isCheckedIn,
    this.currentAttendance,
    this.actions,
  }) : super._();
  @override
  AdminEmployeeDetailData rebuild(
    void Function(AdminEmployeeDetailDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminEmployeeDetailDataBuilder toBuilder() =>
      AdminEmployeeDetailDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminEmployeeDetailData &&
        employee == other.employee &&
        isCheckedIn == other.isCheckedIn &&
        currentAttendance == other.currentAttendance &&
        actions == other.actions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, employee.hashCode);
    _$hash = $jc(_$hash, isCheckedIn.hashCode);
    _$hash = $jc(_$hash, currentAttendance.hashCode);
    _$hash = $jc(_$hash, actions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminEmployeeDetailData')
          ..add('employee', employee)
          ..add('isCheckedIn', isCheckedIn)
          ..add('currentAttendance', currentAttendance)
          ..add('actions', actions))
        .toString();
  }
}

class AdminEmployeeDetailDataBuilder
    implements
        Builder<AdminEmployeeDetailData, AdminEmployeeDetailDataBuilder> {
  _$AdminEmployeeDetailData? _$v;

  ShopStaffMemberBuilder? _employee;
  ShopStaffMemberBuilder get employee =>
      _$this._employee ??= ShopStaffMemberBuilder();
  set employee(ShopStaffMemberBuilder? employee) => _$this._employee = employee;

  bool? _isCheckedIn;
  bool? get isCheckedIn => _$this._isCheckedIn;
  set isCheckedIn(bool? isCheckedIn) => _$this._isCheckedIn = isCheckedIn;

  AdminEmployeeDetailDataCurrentAttendanceBuilder? _currentAttendance;
  AdminEmployeeDetailDataCurrentAttendanceBuilder get currentAttendance =>
      _$this._currentAttendance ??=
          AdminEmployeeDetailDataCurrentAttendanceBuilder();
  set currentAttendance(
    AdminEmployeeDetailDataCurrentAttendanceBuilder? currentAttendance,
  ) => _$this._currentAttendance = currentAttendance;

  ListBuilder<EmployeeAction>? _actions;
  ListBuilder<EmployeeAction> get actions =>
      _$this._actions ??= ListBuilder<EmployeeAction>();
  set actions(ListBuilder<EmployeeAction>? actions) =>
      _$this._actions = actions;

  AdminEmployeeDetailDataBuilder() {
    AdminEmployeeDetailData._defaults(this);
  }

  AdminEmployeeDetailDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _employee = $v.employee?.toBuilder();
      _isCheckedIn = $v.isCheckedIn;
      _currentAttendance = $v.currentAttendance?.toBuilder();
      _actions = $v.actions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminEmployeeDetailData other) {
    _$v = other as _$AdminEmployeeDetailData;
  }

  @override
  void update(void Function(AdminEmployeeDetailDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminEmployeeDetailData build() => _build();

  _$AdminEmployeeDetailData _build() {
    _$AdminEmployeeDetailData _$result;
    try {
      _$result =
          _$v ??
          _$AdminEmployeeDetailData._(
            employee: _employee?.build(),
            isCheckedIn: isCheckedIn,
            currentAttendance: _currentAttendance?.build(),
            actions: _actions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'employee';
        _employee?.build();

        _$failedField = 'currentAttendance';
        _currentAttendance?.build();
        _$failedField = 'actions';
        _actions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminEmployeeDetailData',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
