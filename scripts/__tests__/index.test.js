const { run, checkArgs, calcMSFromDate } = require('../index')

it('should return a month in ms if then is in the past', () => {
  const test = calcMSFromDate('01-17-1981')
  expect(test).toEqual(2629746000)
})
