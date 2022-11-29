#build stage
FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

#run stage

#/usr/src/app/build
#=> builder stage에서 생성된 결과 파일들이 저장되는 폴더

#/usr/share/nginx
#=> nginx가 가동후에 참조하게 되는파일이 저장되는 폴더

#nginx 는 클라이언트 브라우저의 request를 받아서, 
#/usr/share/nginx 폴더에 저장된 빌드 결과 파일을 참조하여
#response 하게 됨

FROM nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx

