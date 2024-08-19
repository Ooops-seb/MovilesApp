enum RoleEnum {
  administrador,
  profesor,
}

const Map<RoleEnum, String> roleEnumValues = {
  RoleEnum.administrador: 'Administrador',
  RoleEnum.profesor: 'Profesor',
};

const Map<String, RoleEnum> roleEnumFromString = {
  'Administrador': RoleEnum.administrador,
  'Profesor': RoleEnum.profesor,
};