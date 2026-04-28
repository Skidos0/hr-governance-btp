using { my.hr_governance as my } from '../db/schema';

service AdminService {
    @requires: 'authenticated-user'
    @(restrict: [
        { grant: 'READ', to: 'Auditor' },
        { grant: '*', to: 'Admin' }
    ])
    @odata.draft.enabled
    entity Employees as projection on my.Employees;
}

annotate AdminService.Employees with @(
    UI: {
        SelectionFields: [ department ],
        LineItem: [
            { Value: name, Label: 'Imię i Nazwisko' },
            { Value: department, Label: 'Dział' },
            { Value: role, Label: 'Rola w firmie' }
        ],
        HeaderInfo: {
            TypeName: 'Pracownik',
            TypeNamePlural: 'Pracownicy',
            Title: { Value: name },
            Description: { Value: role }
        },
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Informacje ogólne',
                Target: '@UI.FieldGroup#Details'
            }
        ],
        FieldGroup #Details: {
            Data: [
                { Value: name, Label: 'Imię' },
                { Value: department, Label: 'Dział' },
                { Value: role, Label: 'Stanowisko' }
            ]
        }
    }
);