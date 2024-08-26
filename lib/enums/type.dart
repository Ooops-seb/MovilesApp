enum TypeEnum {
  permanente,
  ocasional,
}

const Map<TypeEnum, String> typeEnumValues = {
  TypeEnum.permanente: 'Permanente',
  TypeEnum.ocasional: 'Ocasional',
};

const Map<String, TypeEnum> typeEnumFromString = {
  'Permanente': TypeEnum.permanente,
  'Ocasional': TypeEnum.ocasional,
};