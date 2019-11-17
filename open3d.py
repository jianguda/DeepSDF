import os

import numpy as np
import open3d as o3d

# for obj files
# https://3dviewer.net

if __name__ == "__main__":
    # file_path = os.path.join("preprocessed", "04256520", "cd2a6bf7effd529de96ac0c4e1fb9b1a.ply")
    # file_path = os.path.join("reconstructed", "04256520", "cd2a6bf7effd529de96ac0c4e1fb9b1a.ply")
    file_path = os.path.join("test", "04256520_500", "cd2a6bf7effd529de96ac0c4e1fb9b1a.ply")
    mesh = o3d.io.read_triangle_mesh(file_path)
    mesh.compute_vertex_normals()
    print(mesh)
    print(np.asarray(mesh.vertices))
    print(np.asarray(mesh.triangles))
    print(np.asarray(mesh.triangle_normals))
    mesh.paint_uniform_color([1, 0.706, 0])
    o3d.visualization.draw_geometries([mesh])

    # pcd = o3d.io.read_triangle_mesh("cca6e720741a6d00f51f77a6d7299806.obj")
    # o3d.visualization.draw_geometries([pcd])
