enum HoursEnum {
  hora_7_00_9_00,
  hora_9_00_11_00,
  hora_11_00_13_00,
  hora_13_00_15_00,
}

const Map<HoursEnum, String> hoursEnumValues = {
  HoursEnum.hora_7_00_9_00: '7h00-9h00',
  HoursEnum.hora_9_00_11_00: '9h00-11h00',
  HoursEnum.hora_11_00_13_00: '11h00-13h00',
  HoursEnum.hora_13_00_15_00: '13h00-15h00',
};

const Map<String, HoursEnum> hoursEnumFromString = {
  '7h00-9h00': HoursEnum.hora_7_00_9_00,
  '9h00-11h00': HoursEnum.hora_9_00_11_00,
  '11h00-13h00': HoursEnum.hora_11_00_13_00,
  '13h00-15h00': HoursEnum.hora_13_00_15_00,
};