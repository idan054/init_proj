String? companyIdParam, employeeIdParam, dateParam;

void getUrlParams(){
  String? url = Uri.base.toString(); //get complete url
  print('url: ${url}');

  final uriParams = Uri.parse(url.replaceAll('/#/', '/')).queryParameters;
  companyIdParam = uriParams['CompanyID'] ?? uriParams['companyID'] ?? '3417818890';
  employeeIdParam = uriParams['EmployeeId'] ?? uriParams['employeeId'] ?? '557';
  dateParam = uriParams['date'] ?? uriParams['Date'] ?? '1661240852';

  print('companyIdParam: ${companyIdParam}');
  print('employeeIdParam: ${employeeIdParam}');
  print('dateParam: ${dateParam}');
}