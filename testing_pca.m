function testing_pca

load ovariancancer;

[u,s,v] = svd(obs','econ');

figure; hold on;

for i = 1:size(obs,1)
   x = u(:,1)'*obs(i,:)';
   y = u(:,2)'*obs(i,:)';
   z = u(:,3)'*obs(i,:)';
   
   if grp{i} == 'Cancer'
       plot3(x,y,z,'rx','linewidth',2);
   else
       plot3(x,y,z,'bo','linewidth',2)
   end
end

xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

hold off;

end