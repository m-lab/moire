part of moire_test;

void testLocation() {
  group('Location operations', () {
    test("Location constructor", () {
      Locale item = new Locale(continent: 'Europe', country: 'GB', region: 'H9', city: 'London');
      expect(item, isNotNull);
    });

    test("getParent", () {
      Controller c = new Controller();
      Locale l = new Locale(continent: 'Europe', country: 'GB', region: 'H9', city: 'London');

      l.getParent()
          .then((String parent) => expect(parent, 'GB_H9'))
          .catchError((e) => expect(false,'Should not get here: $e'));
    });

    test("getChildren", () {
      Controller c = new Controller();
      Locale l = new Locale(continent: 'Europe', country: 'GB', region: '', city: '');

      l.getChildren()
          .then((List children) => expect(children, ["GB_A1", "GB_A2", "GB_A3", "GB_A4", "GB_A5", "GB_A6", "GB_A7", "GB_A8", "GB_A9", "GB_B1", "GB_B2", "GB_B3", "GB_B4", "GB_B5", "GB_B6", "GB_B7", "GB_B8", "GB_B9", "GB_C1", "GB_C2", "GB_C3", "GB_C4", "GB_C5", "GB_C6", "GB_C7", "GB_C8", "GB_C9", "GB_D1", "GB_D2", "GB_D3", "GB_D4", "GB_D5", "GB_D6", "GB_D7", "GB_D8", "GB_D9", "GB_E1", "GB_E2", "GB_E3", "GB_E4", "GB_E5", "GB_E6", "GB_E7", "GB_E8", "GB_E9", "GB_F1", "GB_F2", "GB_F3", "GB_F4", "GB_F5", "GB_F6", "GB_F7", "GB_F8", "GB_F9", "GB_G1", "GB_G2", "GB_G3", "GB_G4", "GB_G5", "GB_G6", "GB_G7", "GB_G8", "GB_G9", "GB_H1", "GB_H2", "GB_H3", "GB_H4", "GB_H5", "GB_H6", "GB_H7", "GB_H8", "GB_H9", "GB_I1", "GB_I2", "GB_I3", "GB_I4", "GB_I5", "GB_I6", "GB_I7", "GB_I8", "GB_I9", "GB_J1", "GB_J2", "GB_J3", "GB_J4", "GB_J5", "GB_J6", "GB_J7", "GB_J8", "GB_J9", "GB_K1", "GB_K2", "GB_K3", "GB_K4", "GB_K5", "GB_K6", "GB_K7", "GB_K8", "GB_K9", "GB_L1", "GB_L2", "GB_L3", "GB_L4", "GB_L5", "GB_L6", "GB_L7", "GB_L8", "GB_L9", "GB_M1", "GB_M2", "GB_M3", "GB_M4", "GB_M5", "GB_M6", "GB_M7", "GB_M8", "GB_M9", "GB_N1", "GB_N2", "GB_N3", "GB_N4", "GB_N5", "GB_N6", "GB_N7", "GB_N8", "GB_N9", "GB_O1", "GB_O2", "GB_O3", "GB_O4", "GB_O5", "GB_O6", "GB_O7", "GB_O8", "GB_O9", "GB_P1", "GB_P2", "GB_P3", "GB_P4", "GB_P5", "GB_P6", "GB_P7", "GB_P8", "GB_P9", "GB_Q1", "GB_Q2", "GB_Q3", "GB_Q4", "GB_Q5", "GB_Q6", "GB_Q7", "GB_Q8", "GB_Q9", "GB_R1", "GB_R2", "GB_R3", "GB_R4", "GB_R5", "GB_R6", "GB_R7", "GB_R8", "GB_R9", "GB_S1", "GB_S2", "GB_S3", "GB_S4", "GB_S5", "GB_S6", "GB_S7", "GB_S8", "GB_S9", "GB_T1", "GB_T2", "GB_T3", "GB_T4", "GB_T5", "GB_T6", "GB_T7", "GB_T8", "GB_T9", "GB_U1", "GB_U2", "GB_U3", "GB_U4", "GB_U5", "GB_U6", "GB_U7", "GB_U8", "GB_U9", "GB_V1", "GB_V2", "GB_V3", "GB_V4", "GB_V5", "GB_V6", "GB_V7", "GB_V8", "GB_V9", "GB_W1", "GB_W2", "GB_W3", "GB_W4", "GB_W5", "GB_W6", "GB_W7", "GB_W8", "GB_W9", "GB_X1", "GB_X2", "GB_X3", "GB_X4", "GB_X5", "GB_X6", "GB_X7", "GB_X8", "GB_X9", "GB_Y1", "GB_Y2", "GB_Y3", "GB_Y4", "GB_Y5", "GB_Y6", "GB_Y7", "GB_Y8", "GB_Y9", "GB_Z1", "GB_Z2", "GB_Z3", "GB_Z4", "GB_Z5", "GB_Z6", "GB_Z7", "GB_Z8", "GB_Z9"]))
          .catchError((e) => expect(false,'Should not get here: $e'));
    });
  });
}
