enum DayEnum {
  lunes,
  martes,
  miercoles,
  jueves,
  viernes,
  sabado,
}

const Map<DayEnum, String> dayEnumValues = {
  DayEnum.lunes: 'Lunes',
  DayEnum.martes: 'Martes',
  DayEnum.miercoles: 'Miércoles',
  DayEnum.jueves: 'Jueves',
  DayEnum.viernes: 'Viernes',
  DayEnum.sabado: 'Sábado',
};

const Map<String, DayEnum> dayEnumFromString = {
  'Lunes': DayEnum.lunes,
  'Martes': DayEnum.martes,
  'Miércoles': DayEnum.miercoles,
  'Jueves': DayEnum.jueves,
  'Viernes': DayEnum.viernes,
  'Sábado': DayEnum.sabado,
};