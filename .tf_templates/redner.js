var Twig = require('twig');
var fs = require('fs');

const regions = [
  'ap-northeast-1',
  'ap-northeast-2',
  'ap-south-1',
  'ap-southeast-1',
  'ap-southeast-2',
  'ca-central-1',
  'eu-central-1',
  'eu-north-1',
  'eu-west-1',
  'eu-west-2',
  'eu-west-3',
  'me-south-1',
  'ap-east-1',
  'cn-north-1',
  'cn-northwest-1',
  'sa-east-1',
  'us-east-1',
  'us-east-2',
  'us-west-1',
  'us-west-2'
];


Twig.renderFile(__dirname + '/files/config_baselines.tf.twig', { regions: regions }, (err, text) => {
  fs.writeFileSync(__dirname + '/../config_baselines.tf', text);
});

Twig.renderFile(__dirname + '/files/guardduty_baselines.tf.twig', { regions: regions }, (err, text) => {
  fs.writeFileSync(__dirname + '/../guardduty_baselines.tf', text);
});

Twig.renderFile(__dirname + '/files/providers.tf.twig', { regions: regions }, (err, text) => {
  fs.writeFileSync(__dirname + '/../providers.tf', text);
});

Twig.renderFile(__dirname + '/files/outputs.tf.twig', { regions: regions }, (err, text) => {
  fs.writeFileSync(__dirname + '/../outputs.tf', text);
});

Twig.renderFile(__dirname + '/files/vpc_baselines.tf.twig', { regions: regions }, (err, text) => {
  fs.writeFileSync(__dirname + '/../vpc_baselines.tf', text);
});

Twig.renderFile(__dirname + '/files/regions.tf.twig', { regions: regions }, (err, text) => {
  fs.writeFileSync(__dirname + '/regions.tf', text);
});

Twig.renderFile(__dirname + '/files/regions_shared_key.tf.twig', { regions: regions }, (err, text) => {
  fs.writeFileSync(__dirname + '/regions_shared_key.tf', text);
});
