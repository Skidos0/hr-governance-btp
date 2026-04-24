namespace my.hr_governance;

using { managed } from '@sap/cds/common';

entity Employees : managed {
  key ID : Integer;
  name   : String(100);
  role   : String(100);
  department : String(100);
  cloud_access_level : String(20); // Admin, Developer, Auditor
}