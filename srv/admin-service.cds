using { my.hr_governance as my } from '../db/schema';

service AdminService {
    entity Employees as projection on my.Employees;
}