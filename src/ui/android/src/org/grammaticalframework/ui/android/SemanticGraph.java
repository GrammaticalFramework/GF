package org.grammaticalframework.ui.android;

import java.util.*;

public class SemanticGraph {
	private Map<String,Node> nodes;
	private List<Edge> edges;

    private float layoutMinX;
    private float layoutMaxX;
    private float layoutMinY;
    private float layoutMaxY;

	public SemanticGraph() {
		nodes = new HashMap<String,Node>();
		edges = new ArrayList<Edge>();

		layoutMinX = 0;
		layoutMaxX = 0;
		layoutMinY = 0;
		layoutMaxY = 0;
	}

	public Node addNode(String lemma, List senses) {
		Node n = nodes.get(lemma);
		if (n == null) {
			n = new Node(lemma, senses);
		}
		nodes.put(lemma,n);
		return n;
	}

	public Node getNode(String lemma) {
		return nodes.get(lemma);
	}

	public Collection<Node> getNodes() {
		return Collections.unmodifiableCollection(nodes.values());
	}

	public Edge addEdge(Node node1, Node node2) {
		Edge edge = new Edge(node1, node2);
		edges.add(edge);
		return edge;
	}

	private static final int LAYOUT_ITERATIONS = 500;
	private static final float LAYOUT_K = 2;
	private static final float LAYOUT_C = 0.01f;
	private static final float LAYOUT_MAX_VERTEX_MOVEMENT = 0.5f;
	private static final float LAYOUT_MAX_REPULSIVE_FORCE_DISTANCE = 6;

	public void layout() {
        layoutPrepare();
        for (int i = 0; i < LAYOUT_ITERATIONS; i++) {
            layoutIteration();
        }
        layoutCalcBounds();
    }

	public float getLayoutMinX() {
		return layoutMinX;
	}

	public float getLayoutMaxX() {
		return layoutMaxX;
	}

	public float getLayoutMinY() {
		return layoutMinY;
	}

	public float getLayoutMaxY() {
		return layoutMaxY;
	}

    private void layoutPrepare() {
        for (Node node : nodes.values()) {
            node.layoutForceX = 0;
            node.layoutForceY = 0;
        }
    }

    private void layoutIteration() {
		List<Node> prev = new ArrayList<Node>();
        for(Node node1 : this.nodes.values()) {
            for (Node node2 : prev) {
                layoutRepulsive(node1, node2);
            }
            prev.add(node1);
        }

        // Forces on nodes due to edge attractions
        for (Edge edge : edges) {
            layoutAttractive(edge);
        }

        // Move by the given force
        for (Node node : nodes.values()) {
            float xmove = LAYOUT_C * node.layoutForceX;
            float ymove = LAYOUT_C * node.layoutForceY;

            float max = LAYOUT_MAX_VERTEX_MOVEMENT;
            if (xmove >  max) xmove =  max;
            if (xmove < -max) xmove = -max;
            if (ymove >  max) ymove =  max;
            if (ymove < -max) ymove = -max;

            node.layoutPosX += xmove;
            node.layoutPosY += ymove;
            node.layoutForceX = 0;
            node.layoutForceY = 0;
        }
	}

	private void layoutRepulsive(Node node1, Node node2) {
        float dx = node2.layoutPosX - node1.layoutPosX;
        float dy = node2.layoutPosY - node1.layoutPosY;
        float d2 = dx * dx + dy * dy;
        if (d2 < 0.01) {
            dx = (float) (0.1 * Math.random() + 0.1);
            dy = (float) (0.1 * Math.random() + 0.1);
            d2 = dx * dx + dy * dy;
        }
        float d = (float) Math.sqrt(d2);
        if (d < LAYOUT_MAX_REPULSIVE_FORCE_DISTANCE) {
            float repulsiveForce = LAYOUT_K * LAYOUT_K / d;
            node2.layoutForceX += repulsiveForce * dx / d;
            node2.layoutForceY += repulsiveForce * dy / d;
            node1.layoutForceX -= repulsiveForce * dx / d;
            node1.layoutForceY -= repulsiveForce * dy / d;
        }
    }

    private void layoutAttractive(Edge edge) {
        Node node1 = edge.source;
        Node node2 = edge.target;

        float dx = node2.layoutPosX - node1.layoutPosX;
        float dy = node2.layoutPosY - node1.layoutPosY;
        float d2 = dx * dx + dy * dy;
        if (d2 < 0.01) {
            dx = (float) (0.1 * Math.random() + 0.1);
            dy = (float) (0.1 * Math.random() + 0.1);
            d2 = dx * dx + dy * dy;
        }
        float d = (float) Math.sqrt(d2);
        if (d > LAYOUT_MAX_REPULSIVE_FORCE_DISTANCE) {
            d = LAYOUT_MAX_REPULSIVE_FORCE_DISTANCE;
            d2 = d * d;
        }
        float attractiveForce = (d2 - LAYOUT_K * LAYOUT_K) / LAYOUT_K;
        attractiveForce *= Math.log(edge.attraction) * 0.5 + 1;
        
        node2.layoutForceX -= attractiveForce * dx / d;
        node2.layoutForceY -= attractiveForce * dy / d;
        node1.layoutForceX += attractiveForce * dx / d;
        node1.layoutForceY += attractiveForce * dy / d;
    }

    private void layoutCalcBounds() {
		float minx = Float.POSITIVE_INFINITY,
		      maxx = Float.NEGATIVE_INFINITY,
		      miny = Float.POSITIVE_INFINITY,
		      maxy = Float.NEGATIVE_INFINITY;

        for (Node node : nodes.values()) {
            float x = node.layoutPosX;
            float y = node.layoutPosY;
            
            if (x > maxx) maxx = x;
            if (x < minx) minx = x;
            if (y > maxy) maxy = y;
            if (y < miny) miny = y;
        }

        layoutMinX = minx;
        layoutMaxX = maxx;
        layoutMinY = miny;
        layoutMaxY = maxy;
	}

	public static class Node {
		private String lemma;
        private List senses;

		private float layoutPosX;
		private float layoutPosY;
		private float layoutForceX;
        private float layoutForceY;
        
                
        private Node(String lemma, List senses) {
			this.lemma  = lemma;
			this.senses = senses;

			layoutPosX = 0;
			layoutPosY = 0;
			layoutForceX = 0;
			layoutForceY = 0;
		}

		public String getLemma() {
			return lemma;
		}

		public int getSenseCount() {
			return senses.size();
		}

		public Object getSenseId(int i) {
			return senses.get(i);
		}

		public float getLayoutX() {
			return layoutPosX;
		}
		
		public float getLayoutY() {
			return layoutPosY;
		}
	}

	public static class Edge {
		private Node source;
		private Node target;
		private float attraction;
		
		private Edge(Node source, Node target) {
			this.source = source;
			this.target = target;
			this.attraction = 1;
		}
	}
}
