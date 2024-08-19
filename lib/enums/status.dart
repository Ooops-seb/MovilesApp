enum StatusEnum {
  aprobado,
  rechazado,
  pendiente,
}

const Map<StatusEnum, String> statusEnumValues = {
  StatusEnum.aprobado: 'Aprobado',
  StatusEnum.rechazado: 'Rechazado',
  StatusEnum.pendiente: 'Pendiente',
};

const Map<String, StatusEnum> statusEnumFromString = {
  'Aprobado': StatusEnum.aprobado,
  'Rechazado': StatusEnum.rechazado,
  'Pendiente': StatusEnum.pendiente,
};