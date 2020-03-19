import * as AWS from 'aws-sdk';

const s3: AWS.S3 = new AWS.S3({ apiVersion: '2006-03-01' });
const bucket: string = 'vigilant-sniffle-dev-storage';

export function storeResponseInS3(uuid: string, firstName: string, favoriteColor: string) {
  const timestamp = new Date().toISOString();
  return s3
    .putObject({
      Bucket: bucket,
      Key: `responses/${uuid}/${timestamp}.json`,
      Body: JSON.stringify({ uuid, timestamp, firstName, favoriteColor }),
      ACL: 'private',
    })
    .promise()
    .then(() => {});
}